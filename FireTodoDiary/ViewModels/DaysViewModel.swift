//
//  DaysViewModel.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import Foundation
import Firebase

class DaysViewModel: ObservableObject {
    
    @Published var achievedDays: [Int] = []
    
    init() {
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("isAchieved", isEqualTo: true)
            .order(by: "achievedAt")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("HELLO! Fail! Error fetching documents: \(error!)")
                    return
                }
                print("HELLO! Success! Read documents in todos")
                
                // 達成済みTodoの配列
                var achievedTodos: [Todo] = []
                documents.forEach { document in
                    let todo = Todo(document: document)
                    achievedTodos.append(todo)
                }
                
                // Todo達成日の配列
                var achievedDays: [Int] = []
                for todo in achievedTodos {
                    let achievedDay = todo.achievedDay!
                    achievedDays.append(achievedDay)
                }
                // 配列から重複した要素を削除
                achievedDays = NSOrderedSet(array: achievedDays).array as! [Int]
                
                self.achievedDays = achievedDays
            }
    }
}
