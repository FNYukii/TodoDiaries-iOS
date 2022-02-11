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
    
    @Published var unpinnedTodos: [Todo] = []
    @Published var pinnedTodos: [Todo] = []
    @Published var achievedTodos: [Todo] = []
        
    public func readUnpinnedTodos() {
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("isAchieved", isEqualTo: false)
            .whereField("isPinned", isEqualTo: false)
            .addSnapshotListener {(snapshot, error) in
                guard let snapshot = snapshot else {
                    print("HELLO! Fail! Error fetching snapshots: \(error!)")
                    return
                }
                print("HELLO! Success! Read documents from todos")
                snapshot.documentChanges.forEach { diff in
                    
                    if diff.type == .added {
                        let newTodo = self.toTodo(from: diff.document)
                        withAnimation {
                            self.unpinnedTodos.append(newTodo)
                        }
                    }
                    
                    if diff.type == .modified {
                        let id = diff.document.documentID
                        let index = self.unpinnedTodos.firstIndex(where: {$0.id == id})!
                        let newTodo = self.toTodo(from: diff.document)
                        if newTodo.isPinned {
                            withAnimation {
                                self.unpinnedTodos.removeAll(where: {$0.id == id})
                            }
                        } else {
                            withAnimation {
                                self.unpinnedTodos[index] = newTodo
                            }
                        }
                    }
                    
                    if diff.type == .removed {
                        let id = diff.document.documentID
                        withAnimation {
                            self.unpinnedTodos.removeAll(where: {$0.id == id})
                        }
                    }
                }
            }
    }
    
    public func readPinnedTodos() {
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("isAchieved", isEqualTo: false)
            .whereField("isPinned", isEqualTo: true)
            .addSnapshotListener {(snapshot, error) in
                guard let snapshot = snapshot else {
                    print("HELLO! Fail! Error fetching snapshots: \(error!)")
                    return
                }
                print("HELLO! Success! Read documents from todos")
                snapshot.documentChanges.forEach { diff in
                    if diff.type == .added {
                        let newTodo = self.toTodo(from: diff.document)
                        withAnimation {
                            self.pinnedTodos.append(newTodo)
                        }
                    }
                    if diff.type == .modified {
                        let id = diff.document.documentID
                        let index = self.pinnedTodos.firstIndex(where: {$0.id == id})!
                        let newTodo = self.toTodo(from: diff.document)
                        if !newTodo.isPinned {
                            withAnimation {
                                self.pinnedTodos.removeAll(where: {$0.id == id})
                            }
                        } else {
                            withAnimation {
                                self.pinnedTodos[index] = newTodo
                            }
                        }
                    }
                    if diff.type == .removed {
                        let id = diff.document.documentID
                        withAnimation {
                            self.pinnedTodos.removeAll(where: {$0.id == id})
                        }
                    }
                }
            }
    }
    
    public func readAchievedTodos() {
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("isAchieved", isEqualTo: true)
            .addSnapshotListener {(snapshot, error) in
                guard let snapshot = snapshot else {
                    print("HELLO! Fail! Error fetching snapshots: \(error!)")
                    return
                }
                print("HELLO! Success! Read documents from todos")
                snapshot.documentChanges.forEach { diff in
                    if diff.type == .added {
                        let newTodo = self.toTodo(from: diff.document)
                        withAnimation {
                            self.achievedTodos.append(newTodo)
                        }
                    }
                    if diff.type == .modified {
                        let id = diff.document.documentID
                        let index = self.achievedTodos.firstIndex(where: {$0.id == id})!
                        let newTodo = self.toTodo(from: diff.document)
                        if !newTodo.isAchieved {
                            withAnimation {
                                self.achievedTodos.removeAll(where: {$0.id == id})
                            }
                        } else {
                            withAnimation {
                                self.achievedTodos[index] = newTodo
                            }
                        }
                    }
                    if diff.type == .removed {
                        let id = diff.document.documentID
                        withAnimation {
                            self.achievedTodos.removeAll(where: {$0.id == id})
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
        let newTodo = Todo(id: id, userId: userId, content: content, createdAt: createdAt, isPinned: isPinned, isAchieved: isAchieved, achievedAt: achievedAt)
        return newTodo
    }
    
    static func create(content: String, isPinned: Bool, isAchieved: Bool, achievedAt: Date) {
        // User id
        let userId = "kflahglakgihg"
                
        // Add new document
        let db = Firestore.firestore()
        db.collection("todos")
            .addDocument(data: [
                "userId": userId,
                "content": content,
                "createdAt": Date(),
                "isPinned": isPinned,
                "isAchieved": isAchieved,
                "achievedAt": (isAchieved ? achievedAt : nil) as Any
            ]) { error in
                if let error = error {
                    print("HELLO! Fail! Error adding new document: \(error)")
                } else {
                    print("HELLO! Success! Added new document to todos")
                }
            }
    }
    
    static func update(id: String, content: String, isPinned: Bool, isAchieved: Bool, achievedAt: Date) {
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .updateData([
                "content": content,
                "isPinned": isPinned,
                "isAchieved": isAchieved,
                "achievedAt": (isAchieved ? achievedAt : nil) as Any
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating document: \(err)")
                } else {
                    print("HELLO! Success! Updated document")
                }
            }
    }
    
    static func delete(id: String) {
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .delete() { err in
                if let err = err {
                    print("HELLO! Fail! Error removing document: \(err)")
                } else {
                    print("HELLO! Success! Removed document")
                }
            }
    }
}
