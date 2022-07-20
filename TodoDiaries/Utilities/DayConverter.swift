//
//  Day.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/14.
//

import Foundation

class DayConverter {
    
    // orderに使うための、現在の日付のDouble型
    static func nowDouble() -> Double {
        let now = Date()
        let year = Calendar.current.component(.year, from: now)
        let month = Calendar.current.component(.month, from: now)
        let day = Calendar.current.component(.day, from: now)
        let hour = Calendar.current.component(.hour, from: now)
        let minute = Calendar.current.component(.minute, from: now)
        let second = Calendar.current.component(.second, from: now)
        let nowStr: String = String(format: "%04d", year) + String(format: "%02d", month) + String(format: "%02d", day) + String(format: "%02d", hour) + String(format: "%02d", minute) + String(format: "%02d", second)
        let nowDouble: Double = Double(nowStr)!
        return nowDouble
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
    
    // その月のすべての日をyyyymmdd形式で
    static func daysAtTheMonth(year: Int, month: Int) -> [Int] {
        var days: [Int] = []
        let dayCount = dayCountAtTheMonth(year: year, month: month)
        for index in (1...dayCount) {
            let day = year * 10000 + month * 100 + index
            days.append(day)
        }
        days = days.reversed()
        return days
    }
    
    // DateComponents -> "Sunday, February 13, 2022", "2022年2月13日 日曜日"
    static func toStringUpToWeekday(from: Int) -> String {
        let date = toDate(from: from)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: date)
    }
    
    // Date -> 20210923
   static func toInt(from: Date) -> Int {
       let inputDate = from
       let calendar = Calendar(identifier: .gregorian)
       let year = calendar.component(.year, from: inputDate)
       let month = calendar.component(.month, from: inputDate)
       let day = calendar.component(.day, from: inputDate)
       return year * 10000 + month * 100 + day
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
    
    //  ["0", "1", "2", "3", ...] , ["0時", "1時", "2時", "3時", ...]
    static func hourStrings() -> [String] {
        var hourStrings: [String] = []
        for index in 0 ..< 24 {
            // DateCompontentsを生成
            var dateComponents = DateComponents()
            dateComponents.hour = index
            let date = Calendar.current.date(from: dateComponents)!
            // dayStringを生成
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("H")
            let hourString = dateFormatter.string(from: date)
            // 配列に追加
            hourStrings.append(hourString)
        }
        return hourStrings
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
    
    //  ["1", "2", "3", ...] , ["1月", "2月", "3月", ...]
    static func monthStrings() -> [String] {
        var monthStrings: [String] = []
        for index in 0 ..< 12 {
            // DateCompontentsを生成
            var dateComponents = DateComponents()
            dateComponents.month = index + 1
            let date = Calendar.current.date(from: dateComponents)!
            // dayStringを生成
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("MMM")
            let monthString = dateFormatter.string(from: date)
            // 配列に追加
            monthStrings.append(monthString)
        }
        return monthStrings
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
        
    // 月単位でシフトされた、年・月が入ったDateComponents
    static func nowShiftedByMonth(offset: Int) -> DateComponents {
        let date = Date()
        let shiftedDate = Calendar.current.date(byAdding: .month, value: offset, to: date)!
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: shiftedDate)
        return dateComponents
    }
    
}
