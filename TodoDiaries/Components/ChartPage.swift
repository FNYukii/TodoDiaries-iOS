//
//  DayChartPage.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/18.
//

import SwiftUI

struct ChartPage: View {
    
    let pageOffset: Int
    
    @State private var countsOfTodoAchieved: [Int] = []
    @State private var pageTitle = ""
    
    @State private var isAppeared = false
    @State private var isLoaded = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            // ProgressView
            if !isLoaded {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
            if isLoaded {
                Text(pageTitle)
                    .font(.title)
                    .padding(.top)
                HStack {
                    Text("achieved_todos")
                    Text("\(countsOfTodoAchieved.reduce(0) { $0 + $1 })")
                }
                .foregroundColor(.secondary)
                BarChart(countsOfTodoAchieved: countsOfTodoAchieved)
                    .padding(.bottom)
            }
        }
        .frame(height: 300)
        .onAppear(perform: load)
    }
    
    func load() {
        // 現在日時と表示日時の差を表すshiftedNowを生成
        let shiftedNow = DayConverter.nowShiftedByMonth(offset: pageOffset)
        // ページタイトルを変更
        self.pageTitle = DayConverter.toStringUpToMonth(from: shiftedNow)
        // この年月の達成counts配列を取得
        FireTodo.readAchieveCountsAtMonth(year: shiftedNow.year!, month: shiftedNow.month!) { counts in
            self.countsOfTodoAchieved = counts
            self.isLoaded = true
        }
    }
}
