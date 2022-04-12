//
//  SecondView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct SecondView: View {
    
//    @ObservedObject private var daysViewModel = DaysViewModel()
    let achievedDays = [20220411]
    
    init() {
        // 今月の年と月
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let nowYear = now.hour!
        let nowMonth = now.month!
        let startDay = nowYear * 10000 + nowMonth * 100 + 1
        
        // 今月の月末日
        let firstDate = Calendar.current.date(from: DateComponents(year: 2020, month: 2))!
        let add = DateComponents(month: 1, day: -1)
        let endDate = Calendar.current.date(byAdding: add, to: firstDate)!
        let endDay = Day.toInt(from: endDate)
    }
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
//                if !daysViewModel.isLoaded {
//                    ProgressView()
//                        .progressViewStyle(CircularProgressViewStyle())
//                } else {
                    
                    List {
                        ForEach(achievedDays, id: \.self){ achievedDay in
                            DailyAchievedTodosSection(achievedDay: achievedDay)
                        }
                    }
                    
//                    if daysViewModel.achievedDays.count == 0 {
//                        VStack {
//                            Text("no_todo_achieved_yet")
//                            Text("when_you_complete_todo_you_will_see_it_here")
//                        }
//                        .foregroundColor(.secondary)
//                    }
//                }
            }
            
            .navigationTitle("history")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
