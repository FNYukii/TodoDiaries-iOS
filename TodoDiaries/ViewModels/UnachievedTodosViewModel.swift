//
//  TodoViewModel.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import Firebase
import SwiftUI

class UnachievedTodosViewModel: ObservableObject {
    
    @Published var todos: [Todo] = []
    @Published var isLoaded = false
    
    init(isPinned: Bool) {
        if let userId = FireAuth.userId() {
            let db = Firestore.firestore()
            db.collection("todos")
                .whereField("userId", isEqualTo: userId)
                .whereField("achievedAt", isEqualTo: NSNull())
                .whereField("isPinned", isEqualTo: isPinned)
                .order(by: "order")
                .addSnapshotListener {(snapshot, error) in
                    guard let snapshot = snapshot else {
                        print("HELLO! Fail! Error fetching snapshots: \(error!)")
                        return
                    }
                    print("HELLO! Success! Read \(snapshot.documents.count) Todos \(isPinned ? "pinned" : "unpinned").")
                    
                    var todos: [Todo] = []
                    snapshot.documents.forEach { document in
                        let todo = Todo(document: document)
                        todos.append(todo)
                    }
                    withAnimation {
                        self.todos = todos
                    }
                    self.isLoaded = true
                }
        }
    }
    
}
