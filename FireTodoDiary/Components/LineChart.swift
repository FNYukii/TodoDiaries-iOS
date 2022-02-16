//
//  LineChart.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/16.
//

import SwiftUI
import Charts


struct LineChart : UIViewRepresentable {
    
    let showYear: Int
    let showMonth: Int
    
    func makeUIView(context: Context) -> LineChartView {
        // LineChartViewを生成
        let lineChartView = LineChartView()
        
        // TODO: チャートのスタイルをカスタマイズ
        
        return lineChartView
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        // TODO: 表示月の日数を取得
        let dayCountOfTheMonth = Day.dayCountAtTheMonth(year: showYear, month: showMonth)
        
        // TODO: 当月のTodo日別達成数の配列を生成
    }
}
