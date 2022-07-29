//
//  Fire.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import Firebase
import Foundation

class FireTodo {
    
    static func readMaxOrder(isPinned: Bool, completion: ((Double) -> Void)?){
        
        if FireAuth.userId() == nil {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: FireAuth.userId()!)
            .whereField("achievedAt", isEqualTo: NSNull())
            .whereField("isPinned", isEqualTo: isPinned)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error getting Todo: \(err)")
                } else {
                    print("HELLO! Success! Read \(querySnapshot!.documents.count) Todos unachieved & \(isPinned ? "pinned" : "unpinned") to get MaxOrder.")
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
        
        if FireAuth.userId() == nil {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: FireAuth.userId()!)
            .whereField("achievedAt", isEqualTo: NSNull())
            .whereField("isPinned", isEqualTo: isPinned)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error getting documents: \(err)")
                } else {
                    print("HELLO! Success! Read \(querySnapshot!.documents.count) Todos unachieved & \(isPinned ? "pinned" : "unpinned") to get minOrder.")
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
        
        if FireAuth.userId() == nil {
            return
        }
        
        // startDate
        let startDate = Calendar.current.date(from: DateComponents(year: year, month: month, day: 1, hour: 0, minute: 0, second: 0))
        // endDate
        let endDate = Calendar.current.date(from: DateComponents(year: year, month: month + 1, day: 1, hour: 0, minute: 0, second: 0))
        
        // 読み取り
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: FireAuth.userId()!)
            .whereField("achievedAt", isNotEqualTo: NSNull())
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
        
        if FireAuth.userId() == nil {
            return
        }
        
        // startDate
        let startDate = Calendar.current.date(from: DateComponents(year: year, month: month, day: day, hour: 0, minute: 0, second: 0))
        // endDate
        let endDate = Calendar.current.date(from: DateComponents(year: year, month: month, day: day + 1, hour: 0, minute: 0, second: 0))
        
        // 読み取り
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: FireAuth.userId()!)
            .whereField("achievedAt", isNotEqualTo: NSNull())
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
    
    static func createTodo(content: String, isPinned: Bool, achievedAt: Date?, completion: ((String?) -> Void)?) {
        
        if FireAuth.userId() == nil {
            return
        }
        
        // order最大値を取得
        readMaxOrder(isPinned: isPinned) { maxOrder in
            // ドキュメント追加
            let db = Firestore.firestore()
            var ref: DocumentReference? = nil
            ref = db.collection("todos")
                .addDocument(data: [
                    "userId": FireAuth.userId()!,
                    "content": content,
                    "createdAt": Date(),
                    "isPinned": achievedAt == nil ? isPinned : false,
                    "achievedAt": achievedAt as Any,
                    "order": (achievedAt == nil ? maxOrder + 100 : nil) as Any
                ]) { error in
                    // 失敗
                    if let error = error {
                        print("HELLO! Fail! Error adding new Todo. \(error)")
                        completion?(nil)
                        return
                    }
                    
                    // 成功
                    print("HELLO! Success! Added 1 Todo.")
                    completion?(ref!.documentID)
                }
        }
    }
    
    static func updateTodo(id: String, content: String, achievedAt: Date?) {
        
        if FireAuth.userId() == nil {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .updateData([
                "content": content,
                "achievedAt": achievedAt as Any
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating Todo: \(err)")
                } else {
                    print("HELLO! Success! Updated 1 Todo.")
                }
            }
    }
    
    static func updateTodo(id: String, order: Double?) {
        
        if FireAuth.userId() == nil {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .updateData([
                "order": order as Any
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating Todo: \(err)")
                } else {
                    print("HELLO! Success! Updated 1 Todo.")
                }
            }
    }
        
    static func moveTodos(todos: [Todo], sourceIndexSet: IndexSet, destination: Int) {
        // 移動元と移動先のindexを取得
        let from = Int(sourceIndexSet.first!)
        var destination = destination
        if from < destination {
            destination -= 1
        }
        
        if from > destination {
            // Todoを上に移動
            let movedTodo = todos[from]
            var newOrder = 0.0
            if destination == 0 {
                let minOrder = todos.first!.order!
                newOrder = minOrder - 100
            } else {
                let prevOrder = todos[destination - 1].order!
                let nextOrder = todos[destination].order!
                newOrder = (prevOrder + nextOrder) / 2
            }
            FireTodo.updateTodo(id: movedTodo.id, order: newOrder)
        }
        
        if from < destination {
            // Todoを下に移動
            let movedTodo = todos[from]
            var newOrder = 0.0
            if destination == todos.count - 1 {
                let maxOrder = todos.last!.order!
                newOrder = maxOrder + 100
            } else {
                let prevOrder = todos[destination].order!
                let nextOrder = todos[destination + 1].order!
                newOrder = (prevOrder + nextOrder) / 2
            }
            FireTodo.updateTodo(id: movedTodo.id, order: newOrder)
        }
    }
    
    static func pinTodo(id: String) {
        
        if FireAuth.userId() == nil {
            return
        }
        
        // pinnedTodosのorder最大値を読み取り
        readMaxOrder(isPinned: true) { maxOrder in
            
            // Todoをピン留めし、pinnedTodosの一番下へ
            let db = Firestore.firestore()
            db.collection("todos")
                .document(id)
                .updateData([
                    "isPinned": true,
                    "order": maxOrder + 100.0
                ]) { err in
                    if let err = err {
                        print("HELLO! Fail! Error updating Todo: \(err)")
                    } else {
                        print("HELLO! Success! Updated 1 Todo.")
                    }
                }
        }
    }
    
    static func unpinTodo(id: String) {
        
        if FireAuth.userId() == nil {
            return
        }
        
        // unpinnedTodosのorder最小値を読み取り
        readMinOrder(isPinned: false) { minOrder in
            
            // Todoのピン留めを解除し、unpinnedTodosの一番上へ
            let db = Firestore.firestore()
            db.collection("todos")
                .document(id)
                .updateData([
                    "isPinned": false,
                    "order": minOrder - 100.0
                ]) { err in
                    if let err = err {
                        print("HELLO! Fail! Error updating Todo: \(err)")
                    } else {
                        print("HELLO! Success! Updated 1 Todo.")
                    }
                }
        }
    }
    
    static func achieveTodo(id: String, achievedAt: Date) {
        
        if FireAuth.userId() == nil {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .updateData([
                "achievedAt": achievedAt,
                "isPinned": NSNull(),
                "order": NSNull()
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating Todo: \(err)")
                } else {
                    print("HELLO! Success! Updated 1 Todo.")
                }
            }
    }
    
    static func unachieveTodo(id: String, isMakePinned: Bool) {
        
        if FireAuth.userId() == nil {
            return
        }
        
        // isPinnedも設定
        if isMakePinned {
            FireTodo.pinTodo(id: id)
        } else {
            FireTodo.unpinTodo(id: id)
        }
        
        // 未達成へ戻す
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .updateData([
                "achievedAt": NSNull()
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating Todo: \(err)")
                } else {
                    print("HELLO! Success! Updated 1 Todo.")
                }
            }
    }
    
    static func deleteTodo(id: String) {
        
        if FireAuth.userId() == nil {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .delete() { err in
                if let err = err {
                    print("HELLO! Fail! Error removing Todo: \(err)")
                } else {
                    print("HELLO! Success! Deleted 1 Todo.")
                }
            }
    }
    
//    static func cleanTodos() {
//        let db = Firestore.firestore()
//        db.collection("todos")
//            .whereField("userId", isEqualTo: FireAuth.userId()!)
//            .getDocuments() { (querySnapshot, err) in
//                // エラー処理
//                if let err = err {
//                    print("HELLO! Fail! Error getting Todo: \(err)")
//                    return
//                }
//                print("HELLO! Success! Read \(querySnapshot!.documents.count) Todos.")
//
//                // Todos
//                var todos: [Todo] = []
//                querySnapshot!.documents.forEach { document in
//                    let todo = Todo(document: document)
//                    todos.append(todo)
//                }
//
//                // 全てのTodoドキュメントを更新
//                todos.forEach { todo in
//                    db.collection("todos")
//                        .document(todo.id)
//                        .updateData([
//                            "isPinned": NSNull()
//                        ]) { err in
//                            if let err = err {
//                                print("HELLO! Fail! Error updating Todo: \(err)")
//                            } else {
//                                print("HELLO! Success! Updated 1 Todo.")
//                            }
//                        }
//                }
//            }
//    }
    
}
