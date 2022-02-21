//
//  Fire.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import Firebase
import Foundation

class FireTodo {
    
    // 特定の年内の全ての月の、月別達成数の配列
//    static func readCountsOfTodoAchievedAtTheMonth(readYear: Int, completion: (([Int]) -> Void)?) {
//        // startTimestampを生成
//        var startDateComponents = DateComponents()
//        startDateComponents.year = readYear
//        startDateComponents.month = 1
//        startDateComponents.day = 1
//        let startDate = Calendar.current.date(from: startDateComponents)!
//        let startTimestamp = Timestamp(date: startDate)
//        // endTimestampを生成
//        var endDateComponents = DateComponents()
//        endDateComponents.year = readYear + 1
//        endDateComponents.month = 1
//        endDateComponents.day = 1
//        let endDate = Calendar.current.date(from: endDateComponents)!
//        let endTimestamp = Timestamp(date: endDate)
//
//        let userId = CurrentUser.userId()
//        let db = Firestore.firestore()
//        db.collection("todos")
//            .whereField("userId", isEqualTo: userId)
//            .whereField("isAchieved", isEqualTo: true)
//            .order(by: "achievedAt")
//            .start(at: [startTimestamp])
//            .end(before: [endTimestamp])
//            .getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("HELLO! Fail! Error getting documents: \(err)")
//                    return
//                }
//                print("HELLO! Success! Read documents. At year:\(readYear)")
//                if let querySnapshot = querySnapshot {
//                    // achievedMonthsを生成 [1, 1, 1, 2, 2, 3, 4, 4, 4, ...]
//                    var achievedMonths: [Int] = []
//                    querySnapshot.documents.forEach { document in
//                        let timestamp = document.get("achievedAt") as! Timestamp
//                        let date = timestamp.dateValue()
//                        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: date)
//                        let achievedMonth = dateComponents.month!
//                        achievedMonths.append(achievedMonth)
//                    }
//
//                    // countsOfTodoAchievedを生成 [3, 2, 1, 3, ...]
//                    var countsOfTodoAchieved: [Int] = []
//                    for index in 0 ..< 12 {
//                        let month = index + 1
//                        let countOfTodoAchieved = achievedMonths.filter({$0 == month}).count
//                        countsOfTodoAchieved.append(countOfTodoAchieved)
//                    }
//                    completion?(countsOfTodoAchieved)
//                }
//            }
//    }
    
    // 特定の月内の全ての日の、日別達成数を配列
//    static func readCountsOfTodoAchievedAtTheDay(readYear: Int, readMonth: Int, completion: (([Int]) -> Void)?) {
//        // startTimestampを生成
//        var startDateComponents = DateComponents()
//        startDateComponents.year = readYear
//        startDateComponents.month = readMonth
//        startDateComponents.day = 1
//        let startDate = Calendar.current.date(from: startDateComponents)!
//        let startTimestamp = Timestamp(date: startDate)
//        // endTimestampを生成
//        var endDateComponents = DateComponents()
//        endDateComponents.year = readYear
//        endDateComponents.month = readMonth + 1
//        endDateComponents.day = 1
//        let endDate = Calendar.current.date(from: endDateComponents)!
//        let endTimestamp = Timestamp(date: endDate)
//
//        let userId = CurrentUser.userId()
//        let db = Firestore.firestore()
//        db.collection("todos")
//            .whereField("userId", isEqualTo: userId)
//            .whereField("isAchieved", isEqualTo: true)
//            .order(by: "achievedAt")
//            .start(at: [startTimestamp])
//            .end(before: [endTimestamp])
//            .getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("HELLO! Fail! Error getting documents: \(err)")
//                    return
//                }
//                print("HELLO! Success! Read documents. At year:\(readYear), month:\(readMonth)")
//                if let querySnapshot = querySnapshot {
//                    // achievedDaysを生成 [1, 1, 1, 2, 2, 3, 4, 4, 4, ...]
//                    var achievedDays: [Int] = []
//                    querySnapshot.documents.forEach { document in
//                        let timestamp = document.get("achievedAt") as! Timestamp
//                        let date = timestamp.dateValue()
//                        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: date)
//                        let achievedDay = dateComponents.day!
//                        achievedDays.append(achievedDay)
//                    }
//
//                    // countsOfTodoAchievedを生成 [3, 2, 1, 3, ...]
//                    var countsOfTodoAchieved: [Int] = []
//                    let dayCount = Day.dayCountAtTheMonth(year: readYear, month: readMonth)
//                    for index in 0 ..< dayCount {
//                        let day = index + 1
//                        let countOfTodoAchieved = achievedDays.filter({$0 == day}).count
//                        countsOfTodoAchieved.append(countOfTodoAchieved)
//                    }
//                    completion?(countsOfTodoAchieved)
//                }
//            }
//    }
    
    // 特定の日内の全ての時間の、時間別達成数の配列
//    static func readCountsOfTodoAchievedAtTheHour(readYear: Int, readMonth: Int, readDay: Int, completion: (([Int]) -> Void)?) {
//        // startTimestampを生成
//        var startDateComponents = DateComponents()
//        startDateComponents.year = readYear
//        startDateComponents.month = readMonth
//        startDateComponents.day = readDay
//        let startDate = Calendar.current.date(from: startDateComponents)!
//        let startTimestamp = Timestamp(date: startDate)
//        // endTimestampを生成
//        var endDateComponents = DateComponents()
//        endDateComponents.year = readYear
//        endDateComponents.month = readMonth
//        endDateComponents.day = readDay + 1
//        let endDate = Calendar.current.date(from: endDateComponents)!
//        let endTimestamp = Timestamp(date: endDate)
//
//        let userId = CurrentUser.userId()
//        let db = Firestore.firestore()
//        db.collection("todos")
//            .whereField("userId", isEqualTo: userId)
//            .whereField("isAchieved", isEqualTo: true)
//            .order(by: "achievedAt")
//            .start(at: [startTimestamp])
//            .end(before: [endTimestamp])
//            .getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("HELLO! Fail! Error getting Todos: \(err)")
//                    return
//                }
//                if let querySnapshot = querySnapshot {
//                    print("HELLO! Success! Read to count of Todos achieved at: \(readYear)-\(readMonth)-\(readDay), size: \(querySnapshot.documents.count)")
//                    // achievedHoursを生成 [0, 0, 1, 1, 1, 2, 2, 3, 4, 4, 4, ...]
//                    var achievedHours: [Int] = []
//                    querySnapshot.documents.forEach { document in
//                        let timestamp = document.get("achievedAt") as! Timestamp
//                        let date = timestamp.dateValue()
//                        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: date)
//                        let achievedHour = dateComponents.hour!
//                        achievedHours.append(achievedHour)
//                    }
//
//                    // countsOfTodoAchievedを生成 [3, 2, 1, 3, ...]
//                    var countsOfTodoAchieved: [Int] = []
//                    for index in 0 ..< 24 {
//                        let countOfTodoAchieved = achievedHours.filter({$0 == index}).count
//                        countsOfTodoAchieved.append(countOfTodoAchieved)
//                    }
//                    completion?(countsOfTodoAchieved)
//                }
//            }
//    }
    
    // 特定の日の各時間に達成された、Todoの数
    static func readCountsInDay(year: Int, month: Int, day: Int, completion: (([Int]) -> Void)?) {
        // Document ID
        let achievedYmd = String(format: "%04d", year) + String(format: "%02d", month) + String(format: "%02d", day)
        let userId = CurrentUser.userId()
        let documentId = achievedYmd + userId

        let db = Firestore.firestore()
        db.collection("counters")
            .document(documentId)
            .getDocument { (document, error) in
                if let document = document, document.exists {
                    print("HELLO! Success! Read \(documentId). size: 1")
                    // TODO: Create countsInDay array.
                    var countsInDay: [Int] = []
                    for index in 0 ..< 23 {
                        let count = document.get(String(index)) as? Int ?? 0
                        countsInDay.append(count)
                    }
                    completion?(countsInDay)
                } else {
                    print("HELLO! Success! \(documentId) does not exists.")
                    let countsInDay: [Int] = []
                    completion?(countsInDay)
                }
            }
    }
    
    // 特定の日の達成済みTodoの数
    static func readCountOfTodoAchievedAtTheDay(readYear: Int, readMonth: Int, readDay: Int, completion: ((Int) -> Void)?) {
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
                    print("HELLO! Fail! Error getting Todo: \(err)")
                    return
                }
                if let querySnapshot = querySnapshot {
                    print("HELLO! Success! Read to count of Todos achieved at: \(readYear)-\(readMonth)-\(readDay), size: \(querySnapshot.documents.count)")
                    let countOfTodoAchieved = querySnapshot.documents.count
                    completion?(countOfTodoAchieved)
                }
            }
    }
    
    static func readMaxOrder(isPinned: Bool, completion: ((Double) -> Void)?){
        let userId = CurrentUser.userId()
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: userId)
            .whereField("isAchieved", isEqualTo: false)
            .whereField("isPinned", isEqualTo: isPinned)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error getting Todo: \(err)")
                } else {
                    print("HELLO! Success! Read Todos to get MaxOrder. size: \(querySnapshot!.documents.count)")
                    var orders: [Double] = []
                    for document in querySnapshot!.documents {
                        let order = document.get("order") as! Double
                        orders.append(order)
                    }
                    let maxOrder = orders.max() ?? 0.0
                    completion?(maxOrder)
                }
        }
    }
    
    static func readMinOrder(isPinned: Bool, completion: ((Double) -> Void)?){
        let userId = CurrentUser.userId()
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: userId)
            .whereField("isAchieved", isEqualTo: false)
            .whereField("isPinned", isEqualTo: isPinned)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error getting documents: \(err)")
                } else {
                    print("HELLO! Success! Read Todos to get minOrder. size: \(querySnapshot!.documents.count)")
                    var orders: [Double] = []
                    for document in querySnapshot!.documents {
                        let order = document.get("order") as! Double
                        orders.append(order)
                    }
                    let maxOrder = orders.min() ?? 0.0
                    completion?(maxOrder)
                }
        }
    }
    
    static func create(content: String, isPinned: Bool, isAchieved: Bool, achievedAt: Date) {
        // order最大値を取得
        readMaxOrder(isPinned: isPinned) { maxOrder in
            // ドキュメント追加
            let userId = CurrentUser.userId()
            let db = Firestore.firestore()
            db.collection("todos")
                .addDocument(data: [
                    "userId": userId,
                    "content": content,
                    "createdAt": Date(),
                    "isPinned": !isAchieved ? isPinned : false,
                    "isAchieved": isAchieved,
                    "achievedAt": (isAchieved ? achievedAt : nil) as Any,
                    "order": !isAchieved ? maxOrder + 100 : -1.0
                ]) { error in
                    if let error = error {
                        print("HELLO! Fail! Error adding new Todo: \(error)")
                    } else {
                        print("HELLO! Success! Added Todo")
                    }
                }
        }
    }
    
    static func update(id: String, content: String) {
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .updateData([
                "content": content,
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating Todo: \(err)")
                } else {
                    print("HELLO! Success! Updated Todo")
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
                    print("HELLO! Fail! Error updating Todo: \(err)")
                } else {
                    print("HELLO! Success! Updated Todo")
                }
            }
    }
    
    static func update(id: String, isAchieved: Bool) {
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .updateData([
                "isPinned": false,
                "isAchieved": isAchieved,
                "achievedAt": (isAchieved ? Date() : nil) as Any
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating Todo: \(err)")
                } else {
                    print("HELLO! Success! Updated Todo")
                }
            }
    }
    
    static func update(id: String, achievedAt: Date?) {
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .updateData([
                "achievedAt": achievedAt as Any
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating Todo: \(err)")
                } else {
                    print("HELLO! Success! Updated Todo")
                }
            }
    }
    
    static func update(id: String, order: Double) {
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .updateData([
                "order": order
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating Todo: \(err)")
                } else {
                    print("HELLO! Success! Updated Todo")
                }
            }
    }
    
    static func pin(id: String) {
        // pinnedTodosの一番下へ
        readMaxOrder(isPinned: true) { value in
            update(id: id, order: value + 100.0)
            update(id: id, isPinned: true)
        }
    }
    
    static func unpin(id: String) {
        // unpinnedTodosの一番上へ
        readMinOrder(isPinned: false) { value in
            update(id: id, order: value - 100.0)
            update(id: id, isPinned: false)
        }
    }
    
    static func achieve(id: String) {
        update(id: id, order: -1.0)
        update(id: id, isAchieved: true)
        FireCounter.incrementInDay(achievedAt: Date())
    }
    
    static func unachieve(id: String, achievedAt: Date) {
        // unpinnedTodosの一番下へ
        readMaxOrder(isPinned: false) { value in
            update(id: id, order: value + 100.0)
            update(id: id, isAchieved: false)
            FireCounter.decrementInDay(achievedAt: achievedAt)
        }
    }
    
    static func delete(id: String, achievedAt: Date?) {
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .delete() { err in
                if let err = err {
                    print("HELLO! Fail! Error removing Todo: \(err)")
                } else {
                    print("HELLO! Success! Removed Todo")
                    // 達成済みTodoならCounterを更新
                    if let achievedAt = achievedAt {
                        FireCounter.decrementInDay(achievedAt: achievedAt)
                    }
                }
            }
    }
}
