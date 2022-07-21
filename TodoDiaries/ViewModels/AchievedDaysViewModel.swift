//
//  AchievedTodosViewModel.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/04/13.
//

import SwiftUI
import Firebase

class AchievedDaysViewModel: ObservableObject {
    
    @Published var achievedDays: [AchievedDay] = []
    @Published var isLoaded = false
    @Published var documents: [QueryDocumentSnapshot] = []
    
    private var listener: ListenerRegistration? = nil
    
    func read(limit: Int? = nil) {
        
        if let listener = listener {
            listener.remove()
        }
        
        if FireAuth.userId() == nil {
            return
        }
        
        let db = Firestore.firestore()
        var query = db.collection("todos")
            .whereField("userId", isEqualTo: FireAuth.userId()!)
            .whereField("achievedAt", isNotEqualTo: NSNull())
            .order(by: "achievedAt", descending: true)
        
        if let limit = limit {
            query = query
                .limit(to: limit)
        }
        
        listener = query
            .addSnapshotListener {(snapshot, error) in
                guard let snapshot = snapshot else {
                    print("HELLO! Fail! Error fetching snapshots: \(error!)")
                    return
                }
                print("HELLO! Success! Read \(snapshot.documents.count) Todos achieved.")
                
                self.documents = snapshot.documents
                
                // Todosを生成
                var todos: [Todo] = []
                snapshot.documents.forEach { document in
                    let todo = Todo(document: document)
                    todos.append(todo)
                }
                
                // 配列achievedDaysを生成
                var achievedDays: [AchievedDay] = []
                var counter = 0
                for index in 0 ..< todos.count {
                    
                    // ループ初回
                    if index == 0 {
                        // 0番目のTodoの達成年月日
                        let achievedAt = todos.first!.achievedAt!
                        let year = Calendar.current.component(.year, from: achievedAt)
                        let month = Calendar.current.component(.month, from: achievedAt)
                        let day = Calendar.current.component(.day, from: achievedAt)
                        
                        // 配列achievedDaysに最初の要素を追加
                        let achievedDay = AchievedDay(year: year, month: month, day: day, achievedTodos: [])
                        achievedDays.append(achievedDay)
                    }
                    
                    // ループ2回目以降
                    if index > 0 {
                        // index - 1番目のTodoの達成年月日
                        let prevAchievedAt = todos[index - 1].achievedAt!
                        let prevAchievedYear = Calendar.current.component(.year, from: prevAchievedAt)
                        let prevAchievedMonth = Calendar.current.component(.month, from: prevAchievedAt)
                        let prevAchievedDay = Calendar.current.component(.day, from: prevAchievedAt)
                        
                        // index番目のTodoの達成年月日
                        let currentAchievedAt = todos[index].achievedAt!
                        let currentAchievedYear = Calendar.current.component(.year, from: currentAchievedAt)
                        let currentAchievedMonth = Calendar.current.component(.month, from: currentAchievedAt)
                        let currentAchievedDay = Calendar.current.component(.day, from: currentAchievedAt)
                        
                        // index -1番目のTodoの達成年月日とindex番目のTodoの達成年月日が異なっていたら、配列achievedDaysに新しい要素を追加
                        if prevAchievedYear != currentAchievedYear || prevAchievedMonth != currentAchievedMonth || prevAchievedDay != currentAchievedDay {
                            counter += 1
                            let achievedDay = AchievedDay(year: currentAchievedYear, month: currentAchievedMonth, day: currentAchievedDay, achievedTodos: [])
                            achievedDays.append(achievedDay)
                        }
                    }
                    
                    // Todoを配列achievedDaysのcounter番目の要素の配列achievedTodosに追加
                    let todo = todos[index]
                    achievedDays[counter].achievedTodos.append(todo)
                }
                
                // Viewに反映
                withAnimation {
                    self.achievedDays = achievedDays
                    self.isLoaded = true
                }
            }
    }
}
