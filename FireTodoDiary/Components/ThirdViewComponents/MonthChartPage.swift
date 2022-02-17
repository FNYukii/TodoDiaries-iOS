//
//  OnePage.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/16.
//

import SwiftUI
import Firebase

struct MonthChartPage: View {
    
    private let showYear: Int
    private let showMonth: Int
    private let pageTitle: String
    
    @State private var countsOfTodoAchieved: [Int] = []
    @State private var isFirstLoading = true
    
    init(pageOffset: Int){
        let shiftedNow = Day.nowShiftedByMonth(offset: pageOffset)
        self.showYear = shiftedNow.year!
        self.showMonth = shiftedNow.month!
        self.pageTitle = Day.toStringUpToMonth(from: shiftedNow)
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
            FirestoreTodo.countsOfTodoAchievedAtTheDay(readYear: showYear, readMonth: showMonth) { value in
                self.countsOfTodoAchieved = value
                isFirstLoading = false
            }
        }
    }
}
