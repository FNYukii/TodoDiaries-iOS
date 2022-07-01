//
//  Todo.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import Firebase

struct Todo: Identifiable, Equatable {
    let id: String
    let userId: String
    let content: String
    let createdAt: Date
    let isPinned: Bool
    let achievedAt: Date?
    let order: Double?
    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        self.userId = document.get("userId") as! String
        self.content = document.get("content") as! String
        self.createdAt = (document.get("createdAt") as! Timestamp).dateValue()
        self.isPinned = document.get("isPinned") as! Bool
        let achievedTimestamp = document.get("achievedAt") as? Timestamp
        self.achievedAt = achievedTimestamp?.dateValue()
        self.order = document.get("order") as? Double
    }
}
