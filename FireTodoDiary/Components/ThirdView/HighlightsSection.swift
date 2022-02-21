//
//  HighlightsSection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/18.
//

import SwiftUI

struct HighlightsSection: View {
    
    @State private var value0 = 0.0
    @State private var value1 = 0.0
    private let xAxisLabels: [String]
    @State private var message = ""
    
    @State private var isProgressing = true
    
    init() {
        let xAxisLabel0 = NSLocalizedString("yesterday", comment: "")
        let xAxisLabel1 = NSLocalizedString("today", comment: "")
        self.xAxisLabels = [xAxisLabel0, xAxisLabel1]
    }
    
    var body: some View {
        Section(header: Text("highlights")) {
            VStack(alignment: .leading) {
                if isProgressing {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                if !isProgressing {
                    Text(message)
                        .fixedSize(horizontal: false, vertical: true)
                    HorizontalBarChart(value0: value0, value1: value1, xAxisLabels: xAxisLabels)
                        .frame(height: 150)
                }
            }
            .animation(.default, value: message)
        }
        
        .onAppear {
            // 昨日と今日
            let now = Date()
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: now)!
            
            // 昨日のTodo達成数
            let yesterdayComponents = Calendar.current.dateComponents(in: TimeZone.current, from: yesterday)
            FireCounter.readCountsInDay(year: yesterdayComponents.year!, month: yesterdayComponents.month!, day: yesterdayComponents.day!) { countsInYesterday in
                value0 = Double(countsInYesterday.reduce(0, +))
                
                // 今日のTodo達成数
                let todayComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
                FireCounter.readCountsInDay(year: todayComponents.year!, month: todayComponents.month!, day: todayComponents.day!) { countsInToday in
                    value1 = Double(countsInToday.reduce(0, +))
                    
                    // message
                    if value0 == value1 {
                        message = NSLocalizedString("the_count_of_todos_achieved_today_is_the_same_as_yesterday", comment: "")
                    } else if value0 > value1 {
                        message = NSLocalizedString("the_count_of_todos_achieved_today_is_less_than_yesterday", comment: "")
                    } else {
                        message = NSLocalizedString("the_count_of_todos_achieved_today_is_higher_than_yesterday", comment: "")
                    }
                    isProgressing = false
                }
            }
        }
    }
}
