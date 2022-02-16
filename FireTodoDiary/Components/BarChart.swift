//
//  BarChart.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/17.
//

import SwiftUI
import Charts

struct BarChart: UIViewRepresentable {
    
    let achievedTodoCounts: [Int]
    
    func makeUIView(context: Context) -> BarChartView {
        // BarChartViewを生成
        let barChartView = BarChartView()
        
        return barChartView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // BarChartDataEntryを生成
        var barChartDataEntries : [BarChartDataEntry] = []
        for index in (0 ..< achievedTodoCounts.count) {
            let day = Double(index + 1)
            let achievedTodoCount = Double(achievedTodoCounts[index])
            let barChartDataEntry = BarChartDataEntry(x: day, y: achievedTodoCount)
            barChartDataEntries.append(barChartDataEntry)
        }

        // BarChartDataSetを生成
        let barChartDataSet = BarChartDataSet(barChartDataEntries)

        // BarChartDataを生成
        let barChartData = BarChartData()
        barChartData.addDataSet(barChartDataSet)

        // BarChartViewにデータをセット
        uiView.data = barChartData
    }
}
