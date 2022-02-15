//
//  TodoViewModel.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import Foundation
import Firebase
import SwiftUI

class TodosViewModel: ObservableObject {
        
    @Published var todos: [Todo] = []
    
    init(isPinned: Bool? = nil, isAchieved: Bool? = nil, achievedDay: Int? = nil) {
        let db = Firestore.firestore()
        
        var query = db.collection("todos")
            .whereField("userId", isEqualTo: "helloHelloMan")
        
        if isPinned != nil {
            query = query
                .whereField("isPinned", isEqualTo: isPinned!)
        }
        
        if isAchieved != nil {
            query = query
                .whereField("isAchieved", isEqualTo: isAchieved!)
        }
        
        if achievedDay != nil {
            query = query
                .whereField("achievedDay", isEqualTo: achievedDay!)
        }
        
        if isAchieved == true || achievedDay != nil {
            query = query
                .order(by: "achievedAt")
        }
            
        query
            .addSnapshotListener {(snapshot, error) in
                guard let snapshot = snapshot else {
                    print("HELLO! Fail! Error fetching snapshots: \(error!)")
                    return
                }
                print("HELLO! Success! Read documents from todos")
                                
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
