//
//  TodoViewModel.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import Foundation
import Firebase
import SwiftUI

class TodoViewModel: ObservableObject {
    
    @Published var todos: [Todo] = []
    
    init() {
        read()
    }
    
    private func read() {
        let db = Firestore.firestore()
        db.collection("todos")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener {(snapshot, error) in
                guard let snapshot = snapshot else {
                    print("HELLO! Fail! Error fetching snapshots: \(error!)")
                    return
                }
                print("HELLO! Success! Read documents from todos")
                snapshot.documentChanges.forEach { diff in
                    
                    if diff.type == .added {
                        let id = diff.document.documentID
                        let userId = diff.document.get("userId") as! String
                        let content = diff.document.get("content") as! String
                        let createdAt = (diff.document.get("createdAt") as! Timestamp).dateValue()
                        let isPinned = diff.document.get("isPinned") as! Bool
                        let isAchieved = diff.document.get("isAchieved") as! Bool
                        let achievedTimestamp: Timestamp? = diff.document.get("achievedAt") as? Timestamp
                        let achievedAt: Date? = achievedTimestamp?.dateValue()
                        let newTodo = Todo(id: id, userId: userId, content: content, createdAt: createdAt, isPinned: isPinned, isAchieved: isAchieved, achievedAt: achievedAt)
                        withAnimation {
                            self.todos.append(newTodo)
                        }
                    }
                    
                    if diff.type == .modified {
                        //TODO: Update todos array
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
    
    static func create(content: String, isPinned: Bool, isAchieved: Bool, achievedAt: Date) {
        // User id
        let userId = "kflahglakgihg"
        
        let newAchievedAt: Date? = isAchieved ? achievedAt : nil
        
        // Add new document
        let db = Firestore.firestore()
        db.collection("todos")
            .addDocument(data: [
                "userId": userId,
                "content": content,
                "createdAt": Date(),
                "isPinned": isPinned,
                "isAchieved": isAchieved,
                "achievedAt": newAchievedAt as Any
            ]) { error in
                if let error = error {
                    print("HELLO! Fail! Error adding new document: \(error)")
                } else {
                    print("HELLO! Success! Added new document to todos")
                }
            }
    }
    
    static func update(id: String, content: String, isPinned: Bool, isAchieved: Bool, achievedAt: Date) {
        //TODO: Update document
    }
    
    static func delete(id: String) {
        //TODO: Delete document
    }
}
