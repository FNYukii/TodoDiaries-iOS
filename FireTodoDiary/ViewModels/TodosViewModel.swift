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
    
    init(isPinned: Bool? = nil, isAchieved: Bool? = nil, achievedDay: Int? = nil, isWithAnimation: Bool = false) {
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
                
                if !isWithAnimation {
                    var newTodos: [Todo] = []
                    snapshot.documents.forEach { document in
                        let newTodo = self.toTodo(from: document)
                        newTodos.append(newTodo)
                    }
                    self.todos = newTodos
                }
                
                if isWithAnimation {
                    snapshot.documentChanges.forEach { diff in
                        if diff.type == .added {
                            let newTodo = self.toTodo(from: diff.document)
                            if isWithAnimation {
                                withAnimation {
                                    self.todos.append(newTodo)
                                }
                            } else {
                                self.todos.append(newTodo)
                            }
                        }
                        if diff.type == .modified {
                            let newTodo = self.toTodo(from: diff.document)
                            let index = self.todos.firstIndex(where: {$0.id == diff.document.documentID})!
                            if isWithAnimation {
                                withAnimation {
                                    self.todos[index] = newTodo
                                }
                            } else {
                                self.todos[index] = newTodo
                            }
                        }
                        if diff.type == .removed {
                            let id = diff.document.documentID
                            if isWithAnimation {
                                withAnimation {
                                    self.todos.removeAll(where: {$0.id == id})
                                }
                            } else {
                                self.todos.removeAll(where: {$0.id == id})
                            }
                        }
                    }
                }
                
            }
    }
    
    private func toTodo(from: QueryDocumentSnapshot) -> Todo {
        let id = from.documentID
        let userId = from.get("userId") as! String
        let content = from.get("content") as! String
        let createdAt = (from.get("createdAt") as! Timestamp).dateValue()
        let isPinned = from.get("isPinned") as! Bool
        let isAchieved = from.get("isAchieved") as! Bool
        let achievedTimestamp: Timestamp? = from.get("achievedAt") as? Timestamp
        let achievedAt: Date? = achievedTimestamp?.dateValue()
        let achievedDay: Int? = from.get("achievedDay") as? Int
        let newTodo = Todo(id: id, userId: userId, content: content, createdAt: createdAt, isPinned: isPinned, isAchieved: isAchieved, achievedAt: achievedAt, achievedDay: achievedDay)
        return newTodo
    }
}
