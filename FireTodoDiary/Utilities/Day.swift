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
        let year = Calendar.current.component(.year, from: from)
        let month = Calendar.current.component(.month, from: from)
        let day = Calendar.current.component(.day, from: from)
        return year * 10000 + month * 100 + day
    }
    
    // 2022, 2, 14 -> 20220214
    static func toInt(year: Int, month: Int, day: Int) -> Int {
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
    static func toLocalizedString(from: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: from)
    }
    
    // 20210923 -> "Sunday, February 13, 2022", "2022年2月13日 日曜日"
    static func toLocalizedString(from: Int) -> String {
        let date = toDate(from: from)
        return toLocalizedString(from: date)
    }
    
    // Date -> "February 2022", "2022年 2月"
    static func toLocalizedYearAndMonthString(from: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("YYYY MMMM")
        return dateFormatter.string(from: from)
    }
    
    // Date -> "7:31 PM", "19:31"
    static func toLocalizedTimeString(from: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: from)
    }
    
    // 月が前後にシフトされた年月
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
    
    // その月の日数
    static func dayCountAtTheMonth(year: Int, month: Int) -> Int {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month + 1
        dateComponents.day = 0
        let date = Calendar.current.date(from: dateComponents)!
        let dayCount = Calendar.current.component(.day, from: date)
        return dayCount
    }
}
