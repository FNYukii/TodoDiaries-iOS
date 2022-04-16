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
    
    init() {
        let userId = CurrentUser.userId()
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: userId)
            .whereField("isAchieved", isEqualTo: true)
            .order(by: "achievedAt", descending: true)
            .addSnapshotListener {(snapshot, error) in
                guard let snapshot = snapshot else {
                    print("HELLO! Fail! Error fetching snapshots: \(error!)")
                    return
                }
                print("HELLO! Success! Read Achieved Todos. size: \(snapshot.documents.count)")
                
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
                withAnimation {
                    self.days = days
                    self.isLoaded = true
                }

            }
    }
}
