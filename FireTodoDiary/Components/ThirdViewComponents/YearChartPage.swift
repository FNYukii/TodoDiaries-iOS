//
//  YearChartPage.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/18.
//

import SwiftUI

struct YearChartPage: View {
    
    private let showYear: Int
    private let pageTitle: String
    
    @State private var countsOfTodoAchieved: [Int] = []
    @State private var isFirstLoading = false
    
    init(pageOffset: Int){
        let shiftedNow = Day.nowShiftedByYear(offset: pageOffset)
        self.showYear = shiftedNow.year!
        self.pageTitle = Day.toStringUpToYear(from: shiftedNow)
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
            FirestoreTodo.countsOfTodoAchievedAtTheMonth(readYear: showYear) { value in
                self.countsOfTodoAchieved = value
                isFirstLoading = false
            }
        }
    }
}
