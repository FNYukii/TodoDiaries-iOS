//
//  Todo.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import Foundation

struct Todo: Identifiable {
    let id: String
    let userId: String
    let content: String
    let createdAt: Date
    let isPinned: Bool
    let isAchieved: Bool
    let achievedAt: Date?
    let achievedDay: Int?
}
