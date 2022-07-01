//
//  AchievedTodosViewModel.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/04/13.
//

import SwiftUI
import Firebase

class AchievedDaysViewModel: ObservableObject {
    
    @Published var days: [Day] = []
    @Published var isLoaded = false
    @Published var documents: [QueryDocumentSnapshot] = []
    
    private var listener: ListenerRegistration? = nil
    
    func read(limit: Int? = nil) {
        
        if let listener = listener {
            listener.remove()
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
                
                // すべての達成済みTodoの配列
                var achievedTodos: [Todo] = []
                snapshot.documents.forEach { document in
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
                
                // プロパティに格納
                self.days = days
                self.isLoaded = true
            }
    }
}
