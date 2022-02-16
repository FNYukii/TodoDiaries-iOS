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
        let year = from / 10000
        let month = (from % 10000) / 100
        let day = (from % 100)
        let date = DateComponents(calendar: Calendar.current, year: year, month: month, day: day).date!
        return date
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
    
    // 5 -> June 2022 (if now is Jan 2022)
    static func shiftedDate(monthOffset: Int) -> Date {
        // 現在の年と月を取得
        let now = Date()
        var year = Calendar.current.component(.year, from: now)
        var month = Calendar.current.component(.month, from: now)
        // monthOffsetの数だけ次の月へシフト
        if monthOffset > 0 {
            for _ in 0 ..< monthOffset {
                if month == 12 {
                    month = 1
                    year += 1
                } else {
                    month += 1
                }
            }
        }
        // monthOffsetの数だけ前の月へシフト
        if monthOffset < 0 {
            let absoluteMonthOffset = -monthOffset
            for _ in 0 ..< absoluteMonthOffset {
                if month == 1 {
                    month = 12
                    year -= 1
                } else {
                    month -= 1
                }
            }
        }
        // シフトされたyearとmonthをDate型変数に格納
        let date = DateComponents(calendar: Calendar.current, year: year, month: month).date!
        return date
    }
}
