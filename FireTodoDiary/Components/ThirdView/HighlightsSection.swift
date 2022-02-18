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
    
    var body: some View {
        Section(header: Text("highlights")) {
            VStack(alignment: .leading) {
                Text("今日は昨日よりも多くのTodoを達成しました")
                    .fixedSize(horizontal: false, vertical: true)
                HorizontalBarChart(value0: self.value0, value1: self.value1, xAxixLabels: ["昨日", "今日"])
                    .frame(height: 100)
            }
        }
        
        .onAppear {
            // 昨日のTodo達成数
            let now = Date()
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: now)!
            let yesterdayComponents = Calendar.current.dateComponents(in: TimeZone.current, from: yesterday)
            FirestoreTodo.countOfTodoAchievedAtTheDay(readYear: yesterdayComponents.year!, readMonth: yesterdayComponents.month!, readDay: yesterdayComponents.day!) { value in
                self.value0 = Double(value)
            }
            // 今日のTodo達成数
            let todayComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
            FirestoreTodo.countOfTodoAchievedAtTheDay(readYear: todayComponents.year!, readMonth: todayComponents.month!, readDay: todayComponents.day!) { value in
                self.value1 = Double(value)
            }
        }
    }
}
