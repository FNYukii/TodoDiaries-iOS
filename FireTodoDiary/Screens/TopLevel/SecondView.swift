//
//  SecondView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct SecondView: View {
    
    @State private var days: [Int] = []
    @State private var monthOffset = 0
    
    init() {
        // 今月の年と月
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let nowYear = now.year!
        let nowMonth = now.month!
        let daysAtCurrentMonth = Day.daysAtTheMonth(year: nowYear, month: nowMonth)
        _days = State(initialValue: daysAtCurrentMonth)
    }
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(days, id: \.self){ achievedDay in
                    DailyAchievedTodosSection(achievedDay: achievedDay)
                }
                Button(action: {
                    monthOffset -= 1
                    let yearAndMonthShifted = Day.nowShiftedByMonth(offset: monthOffset)
                    let daysAtPrevMonth = Day.daysAtTheMonth(year: yearAndMonthShifted.year!, month: yearAndMonthShifted.month!)
                    days.append(contentsOf: daysAtPrevMonth)
                }) {
                    Text("load_prev_month")
                }
            }
            
            .navigationTitle("history")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
