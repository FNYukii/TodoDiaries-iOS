//
//  OnePage.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/16.
//

import SwiftUI
import Firebase
import FirebaseDatabase

struct OnePage: View {
    
    private let showYear: Int
    private let showMonth: Int
    @State private var countsOfTodoAchieved: [Int] = []
    
    private let localizedYearAndMonth: String
    @State private var isFirstLoading = true
    
    init(monthOffset: Int){
        let shiftedDateComponents = Day.shiftedDateComponents(monthOffset: monthOffset)
        self.showYear = shiftedDateComponents.year!
        self.showMonth = shiftedDateComponents.month!
        self.localizedYearAndMonth = Day.toLocalizedYearAndMonthString(from: shiftedDateComponents)
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            if isFirstLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            if !isFirstLoading {
                Text(localizedYearAndMonth)
                    .font(.title)
                BarChart(countsOfTodoAchieved: countsOfTodoAchieved)
                Spacer()
            }
        }
        .frame(height: 300)
        
        .onAppear {
            // Read achievedTodoCounts
            FirestoreTodo.countsOfTodoAchievedAtTheMonth(year: showYear, month: showMonth) { achievedTodoCounts in
                self.countsOfTodoAchieved = achievedTodoCounts
                isFirstLoading = false
            }
        }
        
    }
}
