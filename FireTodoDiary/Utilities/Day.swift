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
    
    // Date -> "Sunday, February 13, 2022", "2022年2月13日 日曜日"
    static func toString(from: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: from)
    }
    
    // 20210923 -> "Sunday, February 13, 2022", "2022年2月13日 日曜日"
    static func toString(from: Int) -> String {
        let date = toDate(from: from)
        return toString(from: date)
    }
    
    // Date -> "2022", "2022年"
    static func toStringUpToYear(from: DateComponents) -> String {
        let date = Calendar.current.date(from: from)!
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("YYYY")
        return dateFormatter.string(from: date)
    }
    
    // Date -> "February 2022", "2022年 2月"
    static func toStringUpToMonth(from: DateComponents) -> String {
        let date = Calendar.current.date(from: from)!
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("YYYY MMMM")
        return dateFormatter.string(from: date)
    }
    
    // Date -> "February 14 2022", "2022年 2月 14日"
    static func toStringUpToDay(from: DateComponents) -> String {
        let date = Calendar.current.date(from: from)!
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("YYYY MMMM d")
        return dateFormatter.string(from: date)
    }
    
    // ["1", "2", "3", ...] , ["1日", "2日", "3日", ...]
    static func dayStrings() -> [String] {
        var dayStrings: [String] = []
        
        for index in 0 ..< 31 {
            // DateCompontentsを生成
            var dateComponents = DateComponents()
            dateComponents.day = index + 1
            let date = Calendar.current.date(from: dateComponents)!
            // dayStringを生成
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("d")
            let dayString = dateFormatter.string(from: date)
            // 配列に追加
            dayStrings.append(dayString)
        }
        
        return dayStrings
    }
    
    // Date -> "7:31 PM", "19:31"
    static func toTimeString(from: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: from)
    }
    
    // 20210923 -> Date
    static func toDate(from: Int) -> Date {
        let year = from / 10000
        let month = (from % 10000) / 100
        let day = (from % 100)
        let date = DateComponents(calendar: Calendar.current, year: year, month: month, day: day).date!
        return date
    }
    
    // 年単位でシフトされた、年が入ったDateComponents
    static func dateComponentsShiftedByYear(yearOffset: Int) -> DateComponents {
        let date = Date()
        let shiftedDate = Calendar.current.date(byAdding: .year, value: yearOffset, to: date)!
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: shiftedDate)
        return dateComponents
    }
    
    // 月単位でシフトされた、年・月が入ったDateComponents
    static func dateComponentsShiftedByMonth(monthOffset: Int) -> DateComponents {
        let date = Date()
        let shiftedDate = Calendar.current.date(byAdding: .month, value: monthOffset, to: date)!
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: shiftedDate)
        return dateComponents
    }
    
    //　日単位でシフトされた、年・月・日が入ったDateComponents
    static func dateComponentsShiftedByDay(dayOffset: Int) -> DateComponents {
        let date = Date()
        let shiftedDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: date)!
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: shiftedDate)
        return dateComponents
    }
}
