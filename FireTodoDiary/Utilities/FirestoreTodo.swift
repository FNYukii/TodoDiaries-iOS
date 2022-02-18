//
//  Fire.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import Firebase
import Foundation

class FirestoreTodo {
    
    // 特定の年内の全ての月の、月別達成数の配列
    static func countsOfTodoAchievedAtTheMonth(readYear: Int, completion: (([Int]) -> Void)?) {
        // startTimestampを生成
        var startDateComponents = DateComponents()
        startDateComponents.year = readYear
        startDateComponents.month = 1
        startDateComponents.day = 1
        let startDate = Calendar.current.date(from: startDateComponents)!
        let startTimestamp = Timestamp(date: startDate)
        // endTimestampを生成
        var endDateComponents = DateComponents()
        endDateComponents.year = readYear + 1
        endDateComponents.month = 1
        endDateComponents.day = 1
        let endDate = Calendar.current.date(from: endDateComponents)!
        let endTimestamp = Timestamp(date: endDate)
        
        let userId = CurrentUser.userId()
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: userId)
            .whereField("isAchieved", isEqualTo: true)
            .order(by: "achievedAt")
            .start(at: [startTimestamp])
            .end(before: [endTimestamp])
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error getting documents: \(err)")
                    return
                }
                print("HELLO! Success! Read documents. At year:\(readYear)")
                if let querySnapshot = querySnapshot {
                    // achievedMonthsを生成 [1, 1, 1, 2, 2, 3, 4, 4, 4, ...]
                    var achievedMonths: [Int] = []
                    querySnapshot.documents.forEach { document in
                        let timestamp = document.get("achievedAt") as! Timestamp
                        let date = timestamp.dateValue()
                        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: date)
                        let achievedMonth = dateComponents.month!
                        achievedMonths.append(achievedMonth)
                    }
                    
                    // countsOfTodoAchievedを生成 [3, 2, 1, 3, ...]
                    var countsOfTodoAchieved: [Int] = []
                    for index in 0 ..< 12 {
                        let month = index + 1
                        let countOfTodoAchieved = achievedMonths.filter({$0 == month}).count
                        countsOfTodoAchieved.append(countOfTodoAchieved)
                    }
                    completion?(countsOfTodoAchieved)
                }
            }
    }
    
    // 特定の月内の全ての日の、日別達成数を配列
    static func countsOfTodoAchievedAtTheDay(readYear: Int, readMonth: Int, completion: (([Int]) -> Void)?) {        
        // startTimestampを生成
        var startDateComponents = DateComponents()
        startDateComponents.year = readYear
        startDateComponents.month = readMonth
        startDateComponents.day = 1
        let startDate = Calendar.current.date(from: startDateComponents)!
        let startTimestamp = Timestamp(date: startDate)
        // endTimestampを生成
        var endDateComponents = DateComponents()
        endDateComponents.year = readYear
        endDateComponents.month = readMonth + 1
        endDateComponents.day = 1
        let endDate = Calendar.current.date(from: endDateComponents)!
        let endTimestamp = Timestamp(date: endDate)
        
        let userId = CurrentUser.userId()
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: userId)
            .whereField("isAchieved", isEqualTo: true)
            .order(by: "achievedAt")
            .start(at: [startTimestamp])
            .end(before: [endTimestamp])
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error getting documents: \(err)")
                    return
                }
                print("HELLO! Success! Read documents. At year:\(readYear), month:\(readMonth)")
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
                    
                    // countsOfTodoAchievedを生成 [3, 2, 1, 3, ...]
                    var countsOfTodoAchieved: [Int] = []
                    let dayCount = Day.dayCountAtTheMonth(year: readYear, month: readMonth)
                    for index in 0 ..< dayCount {
                        let day = index + 1
                        let countOfTodoAchieved = achievedDays.filter({$0 == day}).count
                        countsOfTodoAchieved.append(countOfTodoAchieved)
                    }
                    completion?(countsOfTodoAchieved)
                }
            }
    }
    
    // 特定の日内の全ての時間の、時間別達成数の配列
    static func countsOfTodoAchievedAtTheHour(readYear: Int, readMonth: Int, readDay: Int, completion: (([Int]) -> Void)?) {
        // startTimestampを生成
        var startDateComponents = DateComponents()
        startDateComponents.year = readYear
        startDateComponents.month = readMonth
        startDateComponents.day = readDay
        let startDate = Calendar.current.date(from: startDateComponents)!
        let startTimestamp = Timestamp(date: startDate)
        // endTimestampを生成
        var endDateComponents = DateComponents()
        endDateComponents.year = readYear
        endDateComponents.month = readMonth
        endDateComponents.day = readDay + 1
        let endDate = Calendar.current.date(from: endDateComponents)!
        let endTimestamp = Timestamp(date: endDate)
        
        let userId = CurrentUser.userId()
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: userId)
            .whereField("isAchieved", isEqualTo: true)
            .order(by: "achievedAt")
            .start(at: [startTimestamp])
            .end(before: [endTimestamp])
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error getting documents: \(err)")
                    return
                }
                print("HELLO! Success! Read documents. At year:\(readYear), month:\(readMonth), day: \(readDay)")
                if let querySnapshot = querySnapshot {
                    // achievedHoursを生成 [0, 0, 1, 1, 1, 2, 2, 3, 4, 4, 4, ...]
                    var achievedHours: [Int] = []
                    querySnapshot.documents.forEach { document in
                        let timestamp = document.get("achievedAt") as! Timestamp
                        let date = timestamp.dateValue()
                        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: date)
                        let achievedHour = dateComponents.hour!
                        achievedHours.append(achievedHour)
                    }
                    
                    // countsOfTodoAchievedを生成 [3, 2, 1, 3, ...]
                    var countsOfTodoAchieved: [Int] = []
                    for index in 0 ..< 24 {
                        let countOfTodoAchieved = achievedHours.filter({$0 == index}).count
                        countsOfTodoAchieved.append(countOfTodoAchieved)
                    }
                    completion?(countsOfTodoAchieved)
                }
            }
    }
    
    // 特定の日の達成済みTodoの数
    static func countOfTodoAchievedAtTheDay(readYear: Int, readMonth: Int, readDay: Int, completion: ((Int) -> Void)?) {
        // startTimestampを生成
        var startDateComponents = DateComponents()
        startDateComponents.year = readYear
        startDateComponents.month = readMonth
        startDateComponents.day = readDay
        let startDate = Calendar.current.date(from: startDateComponents)!
        let startTimestamp = Timestamp(date: startDate)
        // endTimestampを生成
        var endDateComponents = DateComponents()
        endDateComponents.year = readYear
        endDateComponents.month = readMonth
        endDateComponents.day = readDay + 1
        let endDate = Calendar.current.date(from: endDateComponents)!
        let endTimestamp = Timestamp(date: endDate)
        
        let userId = CurrentUser.userId()
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: userId)
            .whereField("isAchieved", isEqualTo: true)
            .order(by: "achievedAt")
            .start(at: [startTimestamp])
            .end(before: [endTimestamp])
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error getting documents: \(err)")
                    return
                }
                print("HELLO! Success! Read documents. At year:\(readYear), month:\(readMonth), day: \(readDay)")
                if let querySnapshot = querySnapshot {
                    let countOfTodoAchieved = querySnapshot.documents.count
                    completion?(countOfTodoAchieved)
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
                "order": 0
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
                "achievedAt": (isAchieved ? achievedAt : nil) as Any
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
                "achievedAt": (isAchieved ? now : nil) as Any
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
