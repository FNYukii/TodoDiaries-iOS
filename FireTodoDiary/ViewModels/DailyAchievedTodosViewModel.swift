//
//  AchievedTodosViewModel.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/20.
//

import Firebase
import SwiftUI

class DailyAchievedTodosViewModel: ObservableObject {
    
    @Published var todos: [Todo] = []
    @Published var isLoaded = false
    
    init(achievedDay: Int) {
        // startTimestamp
//        let startDate = Calendar.current.date(from: achievedDay)!
        let startDate = Day.toDate(from: achievedDay)
        let startTimestamp = Timestamp(date: startDate)
        // endTimestamp
//        var endDateComponents = achievedDay
//        endDateComponents.day! += 1
//        let endDate = Calendar.current.date(from: endDateComponents)!
        let achievedNextDay = achievedDay + 1
        let endDate = Day.toDate(from: achievedNextDay)
        let endTimestamp = Timestamp(date: endDate)
        
        // Read
        let userId = CurrentUser.userId()
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: userId)
            .whereField("isAchieved", isEqualTo: true)
            .order(by: "achievedAt", descending: true)
            .start(at: [endTimestamp])
            .end(before: [startTimestamp])
            .addSnapshotListener {(snapshot, error) in
                guard let snapshot = snapshot else {
                    print("HELLO! Fail! Error fetching snapshots: \(error!)")
                    return
                }
                print("HELLO! Success! Read Todos achieved at \(achievedDay). size: \(snapshot.documents.count)")
                var todos: [Todo] = []
                snapshot.documents.forEach { document in
                    let todo = Todo(document: document)
                    todos.append(todo)
                }
                withAnimation {
                    self.todos = todos
                    self.isLoaded = true
                }
            }
    }
}
