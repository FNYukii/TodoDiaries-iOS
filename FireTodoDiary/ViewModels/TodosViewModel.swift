//
//  TodoViewModel.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import Firebase
import SwiftUI

class TodosViewModel: ObservableObject {
    
    @Published var todos: [Todo] = []
    
    init(isPinned: Bool? = nil, isAchieved: Bool? = nil, achievedDay: DateComponents? = nil) {
        // User id
        let userId = CurrentUser.userId()
        
        let db = Firestore.firestore()
        var query = db.collection("todos")
            .whereField("userId", isEqualTo: userId)
        
        if let isPinned = isPinned {
            query = query
                .whereField("isPinned", isEqualTo: isPinned)
        }
        
        if let isAchieved = isAchieved {
            query = query
                .whereField("isAchieved", isEqualTo: isAchieved)
                .order(by: "achievedAt")
        }
        
        if let achievedDay = achievedDay {
            // startTimestamp
            let startDate = Calendar.current.date(from: achievedDay)!
            let startTimestamp = Timestamp(date: startDate)
            // endTimestamp
            var endDateComponents = achievedDay
            endDateComponents.day! += 1
            let endDate = Calendar.current.date(from: endDateComponents)!
            let endTimestamp = Timestamp(date: endDate)
            
            query = query
                .order(by: "achievedAt")
                .start(at: [startTimestamp])
                .end(before: [endTimestamp])
        }
        
        query
            .addSnapshotListener {(snapshot, error) in
                guard let snapshot = snapshot else {
                    print("HELLO! Fail! Error fetching snapshots: \(error!)")
                    return
                }
                print("HELLO! Success! Read documents.")
                
                snapshot.documentChanges.forEach { diff in
                    if diff.type == .added {
                        let newTodo = Todo(document: diff.document)
                        withAnimation {
                            self.todos.append(newTodo)
                        }
                    }
                    if diff.type == .modified {
                        let newTodo = Todo(document: diff.document)
                        let index = self.todos.firstIndex(where: {$0.id == diff.document.documentID})!
                        withAnimation {
                            self.todos[index] = newTodo
                        }
                    }
                    if diff.type == .removed {
                        let id = diff.document.documentID
                        withAnimation {
                            self.todos.removeAll(where: {$0.id == id})
                        }
                    }
                }
                
            }
    }
}
