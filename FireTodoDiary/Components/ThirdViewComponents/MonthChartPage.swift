//
//  OnePage.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/16.
//

import SwiftUI
import Firebase
import FirebaseDatabase

struct MonthChartPage: View {
    
    private let showYear: Int
    private let showMonth: Int
    @State private var countsOfTodoAchieved: [Int] = []
    
    private let pageTitle: String
    @State private var isFirstLoading = true
    
    init(pageOffset: Int){
        let shiftedDateComponents = Day.shiftedDateComponents(monthOffset: pageOffset)
        self.showYear = shiftedDateComponents.year!
        self.showMonth = shiftedDateComponents.month!
        self.pageTitle = Day.toLocalizedMonthString(from: shiftedDateComponents)
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            if isFirstLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            if !isFirstLoading {
                Text(pageTitle)
                    .font(.title)
                BarChart(countsOfTodoAchieved: countsOfTodoAchieved)
                Spacer()
            }
        }
        .frame(height: 300)
        
        .onAppear {
            // Read achievedTodoCounts
            FirestoreTodo.countsOfTodoAchievedAtTheDay(year: showYear, month: showMonth) { value in
                self.countsOfTodoAchieved = value
                isFirstLoading = false
            }
        }
        
    }
}
