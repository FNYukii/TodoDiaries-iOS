//
//  Todo.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import Foundation
import Firebase

struct Todo: Identifiable, Equatable {
    let id: String
    let userId: String
    let content: String
    let createdAt: Date
    let isPinned: Bool
    let isAchieved: Bool
    let achievedAt: Date?
    let achievedDay: Int?
    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        self.userId = document.get("userId") as! String
        self.content = document.get("content") as! String
        self.createdAt = (document.get("createdAt") as! Timestamp).dateValue()
        self.isPinned = document.get("isPinned") as! Bool
        self.isAchieved = document.get("isAchieved") as! Bool
        let achievedTimestamp = document.get("achievedAt") as? Timestamp
        self.achievedAt = achievedTimestamp?.dateValue()
        self.achievedDay = document.get("achievedDay") as? Int
    }
}
