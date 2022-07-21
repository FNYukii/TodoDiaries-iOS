//
//  Day.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/14.
//

import Foundation

class DayConverter {
    
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
    
    // 2022, 7, 21 -> "Sunday, February 13, 2022" / "2022年2月13日 日曜日"
    static func toStringUpToWeekday(year: Int, month: Int, day: Int) -> String {
        let date = Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: date)
    }
    
    // Date -> "7:31 PM", "19:31"
    static func toTimeString(from: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: from)
    }
    
    // 年・月 -> "February 2022" / "2022年 2月"
    static func toStringUpToMonth(year: Int, month: Int) -> String {
        let date = Calendar.current.date(from: DateComponents(year: year, month: month))!
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("YYYY MMMM")
        return dateFormatter.string(from: date)
    }
    
    // ["1", "2", "3", ...] / ["1日", "2日", "3日", ...]
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
    
    // 月単位でシフトされた日付の年・月
    static func nowShiftedByMonth(offset: Int) -> (year: Int, month: Int) {
        let date = Date()
        let shiftedDate = Calendar.current.date(byAdding: .month, value: offset, to: date)!
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: shiftedDate)
        return (dateComponents.year!, dateComponents.month!)
    }
    
}
