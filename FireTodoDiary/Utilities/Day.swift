//
//  Day.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/14.
//

import Foundation

class Day {
    
    // Date -> 20220214
    static func toInt(from: Date) -> Int {
        let calendar = Calendar(identifier: .gregorian)
        let year = calendar.component(.year, from: from)
        let month = calendar.component(.month, from: from)
        let day = calendar.component(.day, from: from)
        return year * 10000 + month * 100 + day
    }
    
    // 20210923 -> Date
    static func toDate(from: Int) -> Date {
        let inputYmd = from
        let year = inputYmd / 10000
        let month = (inputYmd % 10000) / 100
        let day = (inputYmd % 100)
        let dateComponent = DateComponents(calendar: Calendar.current, year: year, month: month, day: day)
        return dateComponent.date!
    }
    
    // Date -> "Sunday, February 13, 2022", "2022年2月13日 日曜日"
    static func toDateString(from: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: from)
    }
    
    // 20210923 -> "Sunday, February 13, 2022", "2022年2月13日 日曜日"
    static func toDateString(from: Int) -> String {
        let date = toDate(from: from)
        return toDateString(from: date)
    }
    
    // Date -> "7:31 PM", "19:31"
    static func toTimeString(from: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: from)
    }
}
