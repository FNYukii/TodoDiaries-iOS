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
            
            ZStack {
                
//                if !daysViewModel.isLoaded {
//                    ProgressView()
//                        .progressViewStyle(CircularProgressViewStyle())
//                } else {
                    
                    List {
                        ForEach(days, id: \.self){ achievedDay in
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
