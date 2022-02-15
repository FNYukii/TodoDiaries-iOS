//
//  DaysViewModel.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import Firebase

class DaysViewModel: ObservableObject {
    
    @Published var achievedDays: [Int] = []
    
    init() {
        
        // User id
        let userId = CurrentUser.userId()
        
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: userId)
            .whereField("isAchieved", isEqualTo: true)
            .order(by: "achievedAt")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("HELLO! Fail! Error fetching documents: \(error!)")
                    return
                }
                print("HELLO! Success! Read documents in todos")
                
                // 達成済みTodoの配列
                var newAchievedTodos: [Todo] = []
                documents.forEach { document in
                    let todo = Todo(document: document)
                    newAchievedTodos.append(todo)
                }
                
                // Todo達成日の配列
                var newAchievedDays: [Int] = []
                for todo in newAchievedTodos {
                    let achievedDay = todo.achievedDay!
                    newAchievedDays.append(achievedDay)
                }
                // 配列から重複した要素を削除
                newAchievedDays = NSOrderedSet(array: newAchievedDays).array as! [Int]
                
                // Todo達成日に変化があった際、achievedDaysプロパティに適用
                let difference = newAchievedDays.difference(from: self.achievedDays)
                for change in difference {
                    switch change {
                    case let .remove(offset, _, _):
                        self.achievedDays.remove(at: offset)
                    case let .insert(offset, newElement, _):
                        self.achievedDays.insert(newElement, at: offset)
                    }
                }
                
            }
    }
}
