//
//  DayChartPage.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/18.
//

import SwiftUI

struct ChartPage: View {
    
    let pageOffset: Int
    @Binding var unitSelection: Int
    
    @State private var countsOfTodoAchieved: [Int] = []
    @State private var pageTitle = ""

    @State private var isProgressing = true
        
    var body: some View {
        
        VStack(alignment: .leading) {
            if isProgressing {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            if !isProgressing {
                Text(pageTitle)
                    .font(.title)
                BarChart(unitSelection: unitSelection, countsOfTodoAchieved: countsOfTodoAchieved)
                    .padding(.bottom)
            }
        }
        .frame(height: 300)
        .onAppear(perform: load)
        .animation(.default, value: unitSelection)
        .onChange(of: unitSelection) { _ in
            isProgressing = true
            load()
        }
    }
    
    func load() {
        if unitSelection == 0 {
            let shiftedNow = Day.nowShiftedByDay(offset: pageOffset)
            self.pageTitle = Day.toStringUpToDay(from: shiftedNow)
            FirestoreTodo.countsOfTodoAchievedAtTheHour(readYear: shiftedNow.year!, readMonth: shiftedNow.month!, readDay: shiftedNow.day!) { value in
                self.countsOfTodoAchieved = value
                isProgressing = false
            }
        }
        if unitSelection == 1 {
            let shifetNow = Day.nowShiftedByMonth(offset: pageOffset)
            self.pageTitle = Day.toStringUpToMonth(from: shifetNow)
            FirestoreTodo.countsOfTodoAchievedAtTheDay(readYear: shifetNow.year!, readMonth: shifetNow.month!) { value in
                self.countsOfTodoAchieved = value
                isProgressing = false
            }
        }
        if unitSelection == 2 {
            let shifetNow = Day.nowShiftedByYear(offset: pageOffset)
            self.pageTitle = Day.toStringUpToYear(from: shifetNow)
            FirestoreTodo.countsOfTodoAchievedAtTheMonth(readYear: shifetNow.year!) { value in
                self.countsOfTodoAchieved = value
                isProgressing = false
            }
        }
    }
}
