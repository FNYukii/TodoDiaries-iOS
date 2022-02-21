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

    @State private var isAppeared = false
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
                HStack {
                    Text("total")
                    Text("\(countsOfTodoAchieved.reduce(0) { $0 + $1 })")
                }
                .foregroundColor(.secondary)                    
                BarChart(unitSelection: unitSelection, countsOfTodoAchieved: countsOfTodoAchieved)
                    .padding(.bottom)
            }
        }
        .frame(height: 300)
        .animation(.linear, value: unitSelection)
        
        .onAppear {
            isAppeared = true
            loadCountsOfTodoAchieved()
        }
        
        .onDisappear {
            isAppeared = false
        }
        
        // 親ViewでunitSelectionが変更され、かつAppear済みならデータ読み込み
        .onChange(of: unitSelection) { _ in
            isProgressing = true
            if isAppeared {
                loadCountsOfTodoAchieved()
            }
        }
    }
    
    func loadCountsOfTodoAchieved() {
        if unitSelection == 0 {
            let shiftedNow = Day.nowShiftedByDay(offset: pageOffset)
            self.pageTitle = Day.toStringUpToDay(from: shiftedNow)
            FireTodo.readCountsInDay(year: shiftedNow.year!, month: shiftedNow.month!, day: shiftedNow.day!) { value in
                self.countsOfTodoAchieved = value
                self.isProgressing = false
            }
        }
    }
}
