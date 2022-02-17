//
//  Fire.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import Firebase

class FirestoreTodo {
    
    // TODO: Unused
    static func readCount(isAchieved: Bool, completion: ((Int) -> Void)?) {
        let userId = CurrentUser.userId()
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: userId)
            .whereField("isAchieved", isEqualTo: isAchieved)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error getting documents: \(err)")
                    return
                }
                print("HELLO! Success! Read documents. isAchieved == \(isAchieved)")
                if let querySnapshot = querySnapshot {
                    let todoCount = querySnapshot.documents.count
                    completion?(todoCount)
                }
            }
    }
    
    static func readAchievedTodoCounts(year: Int, month: Int, completion: (([Int]) -> Void)?) {
        // startTimestampを生成
        var startDateComponents = DateComponents()
        startDateComponents.year = year
        startDateComponents.month = month
        startDateComponents.day = 1
        let startDate = Calendar.current.date(from: startDateComponents)!
        let startTimestamp = Timestamp(date: startDate)
        
        // endTimestampを生成
        var endDateComponents = DateComponents()
        endDateComponents.year = year
        endDateComponents.month = month + 1
        endDateComponents.day = 1
        let endDate = Calendar.current.date(from: endDateComponents)!
        let endTimestamp = Timestamp(date: endDate)
        
        let userId = CurrentUser.userId()
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: userId)
            .order(by: "achievedAt")
            .start(at: [startTimestamp])
            .end(before: [endTimestamp])
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error getting documents: \(err)")
                    return
                }
                print("HELLO! Success! Read documents. At year:\(year), month:\(month)")
                if let querySnapshot = querySnapshot {
                    // achievedDaysを生成 [1, 1, 1, 2, 2, 3, 4, 4, 4, ...]
                    var achievedDays: [Int] = []
                    querySnapshot.documents.forEach { document in
                        
                        let timestamp = document.get("achievedAt") as! Timestamp
                        let date = timestamp.dateValue()
                        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: date)
                        let achievedDay = dateComponents.day!
                        achievedDays.append(achievedDay)
                    }
                    
                    // achievedTodoCountsを生成 [3, 2, 1, 3, ...]
                    var achievedTodoCounts: [Int] = []
                    let dayCount = Day.dayCountAtTheMonth(year: year, month: month)
                    for index in 0 ..< dayCount {
                        let day = index + 1
                        let achievedTodoCount = achievedDays.filter({$0 == day}).count
                        achievedTodoCounts.append(achievedTodoCount)
                    }                    
                    completion?(achievedTodoCounts)
                }
            }
    }
    
    static func readCount(achievedDay: Int, completion: ((Int) -> Void)?) {
        let userId = CurrentUser.userId()
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: userId)
            .whereField("achievedDay", isEqualTo: achievedDay)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error getting documents: \(err)")
                    return
                }
                print("HELLO! Success! Read documents. achievedDay == \(achievedDay)")
                if let querySnapshot = querySnapshot {
                    let todoCount = querySnapshot.documents.count
                    completion?(todoCount)
                }
            }
    }
        
    static func create(content: String, isPinned: Bool, isAchieved: Bool, achievedAt: Date) {
        // user id
        let userId = CurrentUser.userId()
        
        // Add new document
        let db = Firestore.firestore()
        db.collection("todos")
            .addDocument(data: [
                "userId": userId,
                "content": content,
                "createdAt": Date(),
                "isPinned": !isAchieved ? isPinned : false,
                "isAchieved": isAchieved,
                "achievedAt": (isAchieved ? achievedAt : nil) as Any,
                "achievedDay": (isAchieved ? Day.toInt(from: achievedAt) : nil) as Any
            ]) { error in
                if let error = error {
                    print("HELLO! Fail! Error adding new document: \(error)")
                } else {
                    print("HELLO! Success! Added new document to todos")
                }
            }
    }
    
    static func update(id: String, content: String, isPinned: Bool, isAchieved: Bool, achievedAt: Date) {
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .updateData([
                "content": content,
                "isPinned": !isAchieved ? isPinned : false,
                "isAchieved": isAchieved,
                "achievedAt": (isAchieved ? achievedAt : nil) as Any,
                "achievedDay": (isAchieved ? Day.toInt(from: achievedAt) : nil) as Any
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating document: \(err)")
                } else {
                    print("HELLO! Success! Updated document")
                }
            }
    }
    
    static func update(id: String, isPinned: Bool) {
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .updateData([
                "isPinned": isPinned
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating document: \(err)")
                } else {
                    print("HELLO! Success! Updated document")
                }
            }
    }
    
    static func update(id: String, isAchieved: Bool) {
        let now = Date()
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .updateData([
                "isPinned": false,
                "isAchieved": isAchieved,
                "achievedAt": (isAchieved ? now : nil) as Any,
                "achievedDay": (isAchieved ? Day.toInt(from: now) : nil) as Any
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating document: \(err)")
                } else {
                    print("HELLO! Success! Updated document")
                }
            }
    }
    
    static func delete(id: String) {
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .delete() { err in
                if let err = err {
                    print("HELLO! Fail! Error removing document: \(err)")
                } else {
                    print("HELLO! Success! Removed document")
                }
            }
    }
}
