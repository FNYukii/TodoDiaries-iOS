//
//  LineChart.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/16.
//

import SwiftUI
import Charts


struct LineChart : UIViewRepresentable {
    
    let achievedTodoCounts: [Int]
    
    func makeUIView(context: Context) -> LineChartView {
        // LineChartViewを生成
        let lineChartView = LineChartView()
        lineChartView.legend.enabled = false //チャートのデータ概要非表示
        lineChartView.rightAxis.enabled = false //右側のY軸目盛り非表示
        lineChartView.leftAxis.axisMinimum = 0.0 //左側のY軸目盛り最小値
        lineChartView.leftAxis.granularity = 1.0 //左側のY軸目盛りの区切り地
        lineChartView.doubleTapToZoomEnabled = false //ダブルタップによるズームを無効
        lineChartView.scaleXEnabled = false //X軸ピンチアウトを無効
        lineChartView.scaleYEnabled = false //Y軸ピンチアウトを無効
        lineChartView.highlightPerDragEnabled = false //ドラッグによるハイライト線表示を無効
        lineChartView.highlightPerTapEnabled = false //タップによるハイライト線表示を無効
        
        return lineChartView
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        // ChartDataEntryを生成
        var chartDataEntries : [ChartDataEntry] = []
        for index in (0 ..< achievedTodoCounts.count) {
            let day = Double(index + 1)
            let achievedTodoCount = Double(achievedTodoCounts[index])
            let chartDataEntry = ChartDataEntry(x: day, y: achievedTodoCount)
            chartDataEntries.append(chartDataEntry)
        }
        
        // LineChartDataSetを生成
        let lineChartDataSet = LineChartDataSet(entries: chartDataEntries)
        lineChartDataSet.drawCirclesEnabled = false // 折れ線グラフのデータ値の丸を非表示
        lineChartDataSet.setColor(UIColor.systemBlue) // 折れ線グラフの色
        
        // LineChartDataを生成
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartData.setDrawValues(false) // 折れ線グラフたちのデータ値非表示
        
        // LineChartViewが表示するデータを更新
        uiView.data = lineChartData
    }
}
