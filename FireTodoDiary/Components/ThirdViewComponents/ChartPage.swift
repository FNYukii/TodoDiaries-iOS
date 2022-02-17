//
//  OnePage.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/16.
//

import SwiftUI
import Firebase

struct ChartPage: View {
    
    private let showMonth: DateComponents
    private let pageTitle: String
    
    @State private var countsOfTodoAchieved: [Int] = []
    @State private var isFirstLoading = true
    
    init(pageOffset: Int){
        self.showMonth = Day.dateComponentsShiftedByMonth(monthOffset: pageOffset)
        self.pageTitle = Day.toStringUpToMonth(from: showMonth)
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
            FirestoreTodo.countsOfTodoAchievedAtTheDay(inThe: showMonth) { value in
                self.countsOfTodoAchieved = value
                isFirstLoading = false
            }
        }
        
    }
}
