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
            }
            
            .navigationTitle("history")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        // 来月を表示
                        Button(action: {
                            monthOffset += 1
                            let shiftedNow = Day.nowShiftedByMonth(offset: monthOffset)
                            days = Day.daysAtTheMonth(year: shiftedNow.year!, month: shiftedNow.month!)
                        }) {
                            Label("next_month", systemImage: "arrow.forward")
                        }
                        // 先月を表示
                        Button(action: {
                            monthOffset -= 1
                            let shiftedNow = Day.nowShiftedByMonth(offset: monthOffset)
                            days = Day.daysAtTheMonth(year: shiftedNow.year!, month: shiftedNow.month!)
                        }) {
                            Label("prev_month", systemImage: "arrow.backward")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .font(.title2)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
