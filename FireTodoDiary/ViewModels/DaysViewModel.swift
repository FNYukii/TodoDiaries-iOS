//
//  DaysViewModel.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import Firebase

class DaysViewModel: ObservableObject {
    
    @Published var achievedDays: [DateComponents] = []
    @Published var isLoaded = false
    
    init() {
        // User id
        let userId = CurrentUser.userId()
        
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: userId)
            .whereField("isAchieved", isEqualTo: true)
            .order(by: "achievedAt", descending: true)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("HELLO! Fail! Error fetching documents: \(error!)")
                    return
                }
                print("HELLO! Success! Read documents. isAchieved == true")
                
                // 達成済みTodoの配列
                var newAchievedTodos: [Todo] = []
                documents.forEach { document in
                    let todo = Todo(document: document)
                    newAchievedTodos.append(todo)
                }
                
                // achievedDatesを生成
                var newAchievedDays: [DateComponents] = []
                for todo in newAchievedTodos {
                    let achievedAt = todo.achievedAt!
                    var achievedDayDateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: achievedAt)
                    achievedDayDateComponents.hour = 0
                    achievedDayDateComponents.minute = 0
                    achievedDayDateComponents.second = 0
                    achievedDayDateComponents.nanosecond = 0
                    newAchievedDays.append(achievedDayDateComponents)
                }
                
                // achievedDatesから重複した要素を削除
                newAchievedDays = NSOrderedSet(array: newAchievedDays).array as! [DateComponents]
                
                // achievedDatesに変化があった際、プロパティに適用
                let difference = newAchievedDays.difference(from: self.achievedDays)
                for change in difference {
                    switch change {
                    case let .remove(offset, _, _):
                        self.achievedDays.remove(at: offset)
                    case let .insert(offset, newElement, _):
                        self.achievedDays.insert(newElement, at: offset)
                    }
                }
                
                // ロード完了
                self.isLoaded = true
            }
    }
}
