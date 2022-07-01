//
//  HighlightsSection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/18.
//

import SwiftUI

struct HighlightsSection: View {
    
    @State private var message = ""
    
    @State private var value0 = 0.0
    @State private var value1 = 0.0
    private let xAxisLabels: [String]
    
    @State private var isLoaded = false
    
    init() {
        let xAxisLabel0 = NSLocalizedString("yesterday", comment: "")
        let xAxisLabel1 = NSLocalizedString("today", comment: "")
        self.xAxisLabels = [xAxisLabel0, xAxisLabel1]
    }
    
    var body: some View {
        Section(header: Text("highlights")) {
            // ProgressView
            if !isLoaded {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            if isLoaded {
                VStack(alignment: .leading) {
                    // Message
                    if value0 == value1 {
                        Text("the_count_of_todos_achieved_today_is_the_same_as_yesterday")
                            .fixedSize(horizontal: false, vertical: true)
                    } else if value0 > value1 {
                        Text("the_count_of_todos_achieved_today_is_less_than_yesterday")
                            .fixedSize(horizontal: false, vertical: true)
                    } else {
                        Text("the_count_of_todos_achieved_today_is_higher_than_yesterday")
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    // BarChart
                    HorizontalBarChart(value0: value0, value1: value1, xAxisLabels: xAxisLabels)
                        .frame(height: 150)
                }
                .frame(height: 230)
                .animation(.default, value: message)
            }
        }
        
        .onAppear {
            // 昨日のTodo達成数
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
            let yesterdayComponents = Calendar.current.dateComponents(in: TimeZone.current, from: yesterday)
            FireTodo.readAchieveCountAtDay(year: yesterdayComponents.year!, month: yesterdayComponents.month!, day: yesterdayComponents.day!) { countAtYesterday in
                value0 = Double(countAtYesterday)
                isLoaded = true
            }
            
            // 今日のTodo達成数
            let todayComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
            FireTodo.readAchieveCountAtDay(year: todayComponents.year!, month: todayComponents.month!, day: todayComponents.day!) { countAtToday in
                value1 = Double(countAtToday)
                isLoaded = true
            }
        }
    }
}
