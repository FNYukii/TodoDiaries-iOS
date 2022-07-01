//
//  Fire.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import Firebase
import Foundation

class FireTodo {
    
    static func readAchievedTodos(limit: Int?, completion: (([Day]) -> Void)?) {
        let db = Firestore.firestore()
        var query = db.collection("todos")
            .whereField("userId", isEqualTo: FireAuth.userId()!)
            .whereField("isAchieved", isEqualTo: true)
            .order(by: "achievedAt", descending: true)
        
        if let limit = limit {
            query = query
                .limit(to: limit)
        }
                
        query
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO. Error getting documents: \(err)")
                } else {
                    if let querySnapshot = querySnapshot {
                        print("HELLO. Read \(querySnapshot.documents.count) Todos achieved.")
                        
                        // すべての達成済みTodoの配列
                        var achievedTodos: [Todo] = []
                        querySnapshot.documents.forEach { document in
                            let todo = Todo(document: document)
                            achievedTodos.append(todo)
                        }
                        
                        // 配列daysを生成
                        var days: [Day] = []
                        var counter = 0
                        for index in 0 ..< achievedTodos.count {
                            // ループ初回。daysの最初の要素としてDayを追加
                            if index == 0 {
                                days.append(Day(ymd: DayConverter.toInt(from: achievedTodos[0].achievedAt!), achievedTodos: []))
                            }
                            // ループ2回目以降。前回のachievedTodoの達成日と比較。違ったらdaysに新しいDayを追加
                            if index > 0 {
                                let prevAchievedYmd = DayConverter.toInt(from: achievedTodos[index - 1].achievedAt!)
                                let currentAchievedYmd = DayConverter.toInt(from: achievedTodos[index].achievedAt!)
                                if prevAchievedYmd != currentAchievedYmd {
                                    counter += 1
                                    days.append(Day(ymd: DayConverter.toInt(from: achievedTodos[index].achievedAt!), achievedTodos: []))
                                }
                            }
                            // Day.achievedTodosにachivedTodoを追加
                            days[counter].achievedTodos.append(achievedTodos[index])
                        }
                        
                        // 配列days完成
                        completion?(days)
                    }
                }
            }
    }
    
    static func readMaxOrder(isPinned: Bool, completion: ((Double) -> Void)?){
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: FireAuth.userId()!)
            .whereField("isAchieved", isEqualTo: false)
            .whereField("isPinned", isEqualTo: isPinned)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error getting Todo: \(err)")
                } else {
                    print("HELLO! Success! Read \(querySnapshot!.documents.count) Todos unachieved to get MaxOrder.")
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
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: FireAuth.userId()!)
            .whereField("isAchieved", isEqualTo: false)
            .whereField("isPinned", isEqualTo: isPinned)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error getting documents: \(err)")
                } else {
                    print("HELLO! Success! Read \(querySnapshot!.documents.count) Todos unachieved to get minOrder.")
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
    
    static func readAchieveCountsAtMonth(year: Int, month: Int, completion: (([Int]) -> Void)?) {
        // startDate
        let startDate = Calendar.current.date(from: DateComponents(year: year, month: month, day: 1, hour: 0, minute: 0, second: 0))
        // endDate
        let endDate = Calendar.current.date(from: DateComponents(year: year, month: month + 1, day: 1, hour: 0, minute: 0, second: 0))
        
        // 読み取り
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: FireAuth.userId()!)
            .whereField("isAchieved", isEqualTo: true)
            .order(by: "achievedAt")
            .start(at: [startDate!])
            .end(before: [endDate!])
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error getting documents: \(err)")
                    return
                }
                print("HELLO! Success! Read \(querySnapshot!.documents.count) Todos achieved at \(year)/\(month).")
                
                // Todos
                var todos: [Todo] = []
                querySnapshot!.documents.forEach { document in
                    let todo = Todo(document: document)
                    todos.append(todo)
                }
                
                // この年月の日数
                let dayCount = DayConverter.dayCountAtTheMonth(year: year, month: month)
                
                // counts配列の生成開始
                var counts: [Int] = []
                for index in 1 ... dayCount {
                    // todos配列内の全todoをチェックして、この日のcountを生成
                    var count = 0
                    todos.forEach { todo in
                        // 比較のために3つのDateを用意
                        let achievedAt: Date = todo.achievedAt!
                        let currentDay: Date = Calendar.current.date(from: DateComponents(year: year, month: month, day:index))!
                        let nextDay: Date = Calendar.current.date(from: DateComponents(year: year, month: month, day:index + 1))!
                        // todoのachievedAtがこの日内かどうか比較
                        if achievedAt >= currentDay && achievedAt < nextDay {
                            count += 1
                        }
                    }
                    
                    // この日のcountが生成できたら、counts配列に追加
                    counts.append(count)
                }
                
                // counts配列をreturn
                completion?(counts)
            }
    }
    
    static func readAchieveCountAtDay(year: Int, month: Int, day: Int, completion: ((Int) -> Void)?) {
        // startDate
        let startDate = Calendar.current.date(from: DateComponents(year: year, month: month, day: day, hour: 0, minute: 0, second: 0))
        // endDate
        let endDate = Calendar.current.date(from: DateComponents(year: year, month: month, day: day + 1, hour: 0, minute: 0, second: 0))
        
        // 読み取り
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: FireAuth.userId()!)
            .whereField("isAchieved", isEqualTo: true)
            .order(by: "achievedAt")
            .start(at: [startDate!])
            .end(before: [endDate!])
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error getting documents: \(err)")
                    return
                }
                print("HELLO! Success! Read \(querySnapshot!.documents.count) Todos achieved at \(year)/\(month)/\(day).")
                
                // countを生成してreturn
                let count = querySnapshot!.documents.count
                completion?(count)
            }
    }
    
    static func createTodo(content: String, isPinned: Bool, isAchieved: Bool, achievedAt: Date) {
        // order最大値を取得
        readMaxOrder(isPinned: isPinned) { maxOrder in
            // ドキュメント追加
            let db = Firestore.firestore()
            db.collection("todos")
                .addDocument(data: [
                    "userId": FireAuth.userId()!,
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
    
    static func updateTodo(id: String, content: String) {
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
    
    static func updateTodo(id: String, isPinned: Bool) {
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
    
    static func updateTodo(id: String, isAchieved: Bool) {
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
    
    static func updateTodo(id: String, achievedAt: Date?) {
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
    
    static func updateTodo(id: String, order: Double) {
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
    
    static func pinTodo(id: String) {
        // pinnedTodosの一番下へ
        readMaxOrder(isPinned: true) { value in
            updateTodo(id: id, order: value + 100.0)
            updateTodo(id: id, isPinned: true)
        }
    }
    
    static func unpinTodo(id: String) {
        // unpinnedTodosの一番上へ
        readMinOrder(isPinned: false) { value in
            updateTodo(id: id, order: value - 100.0)
            updateTodo(id: id, isPinned: false)
        }
    }
    
    static func achieveTodo(id: String, achievedAt: Date? = nil) {
        updateTodo(id: id, order: -1.0)
        updateTodo(id: id, isAchieved: true)
        if let achievedAt = achievedAt {
            updateTodo(id: id, achievedAt: achievedAt)
        }
    }
    
    static func unachieveTodo(id: String, achievedAt: Date) {
        // unpinnedTodosの一番下へ
        readMaxOrder(isPinned: false) { value in
            updateTodo(id: id, order: value + 100.0)
            updateTodo(id: id, isAchieved: false)
        }
    }
    
    static func deleteTodo(id: String, achievedAt: Date? = nil) {
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .delete() { err in
                if let err = err {
                    print("HELLO! Fail! Error removing Todo: \(err)")
                } else {
                    print("HELLO! Success! Removed Todo")
                }
            }
    }
}
