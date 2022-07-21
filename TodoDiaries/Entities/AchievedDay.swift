//
//  AchievedDay.swift
//  TodoDiaries
//
//  Created by Yu on 2022/07/21.
//

import Foundation

struct AchievedDay: Identifiable, Equatable {
    var id = UUID()
    var year: Int
    var month: Int
    var day: Int
    var achievedTodos: [Todo]
}
