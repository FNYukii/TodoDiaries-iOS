//
//  Day.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/04/13.
//

import Foundation

struct Day: Identifiable {
    var id = UUID()
    var ymd: Int
    var achievedTodos: [Todo]
}
