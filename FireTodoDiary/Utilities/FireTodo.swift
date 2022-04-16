//
//  Fire.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import Firebase
import Foundation

class FireTodo {
    
    static func achievedTodos(completion: (([Day]) -> Void)?) {
                
        let userId = CurrentUser.userId()
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: userId)
            .whereField("isAchieved", isEqualTo: true)
            .order(by: "achievedAt", descending: true)
            .limit(to: 20)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO. Error getting documents: \(err)")
                } else {
                    if let querySnapshot = querySnapshot {
                        print("HELLO. Read achievedTodos. size: \(querySnapshot.documents.count)")
                        
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
    
    static func achieve(id: String, achievedAt: Date? = nil) {
        update(id: id, order: -1.0)
        update(id: id, isAchieved: true)
        if let achievedAt = achievedAt {
            update(id: id, achievedAt: achievedAt)
        }
        FireCounter.increment(achievedAt: Date())
    }
    
    static func unachieve(id: String, achievedAt: Date) {
        // unpinnedTodosの一番下へ
        readMaxOrder(isPinned: false) { value in
            update(id: id, order: value + 100.0)
            update(id: id, isAchieved: false)
            FireCounter.decrement(achievedAt: achievedAt)
        }
    }
    
    static func delete(id: String, achievedAt: Date? = nil) {
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
                        FireCounter.decrement(achievedAt: achievedAt)
                    }
                }
            }
    }
}
