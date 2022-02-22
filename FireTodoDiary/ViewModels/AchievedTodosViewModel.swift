//
//  AchievedTodosViewModel.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/20.
//

import Firebase
import SwiftUI

class AchievedTodosViewModel: ObservableObject {
    
    @Published var todos: [Todo] = []
    @Published var isLoaded = false
    
    init(achievedDay: DateComponents) {
        // startTimestamp
        let startDate = Calendar.current.date(from: achievedDay)!
        let startTimestamp = Timestamp(date: startDate)
        // endTimestamp
        var endDateComponents = achievedDay
        endDateComponents.day! += 1
        let endDate = Calendar.current.date(from: endDateComponents)!
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
                print("HELLO! Success! Read Todos achieved at \(achievedDay.year!)-\(achievedDay.month!)-\(achievedDay.day!). size: \(snapshot.documents.count)")
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
