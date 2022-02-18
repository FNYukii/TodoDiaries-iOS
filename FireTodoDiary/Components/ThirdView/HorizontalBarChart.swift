//
//  HorizontalBarChart.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/18.
//

import SwiftUI
import Charts

struct HorizontalBarChart: UIViewRepresentable {
    
    func makeUIView(context: Context) -> HorizontalBarChartView  {
        // HorizontalBarChartViewを生成
        let horizontalBarChartView = HorizontalBarChartView()
        // TODO: チャートをスタイリング
        
        horizontalBarChartView.data = barChartData()
        
        return horizontalBarChartView
    }
    
    func updateUIView(_ uiView: HorizontalBarChartView, context: Context) {
        
    }
    
    private func barChartData() -> BarChartData {
        
        let countsOfTodoAchieved = [2, 5]
        
        // BarChartDataEntryを生成
        var barChartDataEntries : [BarChartDataEntry] = []
        for index in (0 ..< countsOfTodoAchieved.count) {
            let day = Double(index + 1)
            let achievedTodoCount = Double(countsOfTodoAchieved[index])
            let barChartDataEntry = BarChartDataEntry(x: day, y: achievedTodoCount)
            barChartDataEntries.append(barChartDataEntry)
        }
        // BarChartDataSetを生成
        let barChartDataSet = BarChartDataSet(barChartDataEntries)
        barChartDataSet.setColor(UIColor.systemBlue)
        // BarChartDataを生成
        let barChartData = BarChartData()
        barChartData.addDataSet(barChartDataSet)
        barChartData.setDrawValues(false)
        return barChartData
    }
    
}
