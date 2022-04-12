//
//  SecondView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct SecondView: View {
    
//    @ObservedObject private var daysViewModel = DaysViewModel()
    var days: [Int] = []
    
    init() {
        // 今月の年と月
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let nowYear = now.year!
        let nowMonth = now.month!
        self.days = Day.daysAtTheMonth(year: nowYear, month: nowMonth)
    }
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(days, id: \.self){ achievedDay in
                    DailyAchievedTodosSection(achievedDay: achievedDay)
                }
            }
            
            .navigationTitle("history")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
