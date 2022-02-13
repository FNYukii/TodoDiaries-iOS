//
//  Day.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/14.
//

import Foundation

class Day {
    
    // Date -> 20220214
    static func toYmd(from: Date) -> Int {
        let calendar = Calendar(identifier: .gregorian)
        let year = calendar.component(.year, from: from)
        let month = calendar.component(.month, from: from)
        let day = calendar.component(.day, from: from)
        return year * 10000 + month * 100 + day
    }
}
