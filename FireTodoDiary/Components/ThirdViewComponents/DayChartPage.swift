//
//  DayChartPage.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/18.
//

import SwiftUI

struct DayChartPage: View {
    
    private let showYear: Int
    private let showMonth: Int
    private let showDay: Int
    private let pageTitle: String
    
    @State private var countsOfTodoAchieved: [Int] = []
    @State private var isFirstLoading = false
    
    init(pageOffset: Int){
        let shiftedNow = Day.nowShiftedByDay(offset: pageOffset)
        self.showYear = shiftedNow.year!
        self.showMonth = shiftedNow.month!
        self.showDay = shiftedNow.day!
        self.pageTitle = Day.toStringUpToDay(from: shiftedNow)
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
                    .padding(.bottom)
            }
        }
        .frame(height: 300)
        
        .onAppear {
            FirestoreTodo.countsOfTodoAchievedAtTheHour(readYear: showYear, readMonth: showMonth, readDay: showDay) { value in
                self.countsOfTodoAchieved = value
                isFirstLoading = false
            }
        }
    }
}
