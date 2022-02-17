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
        barChartView.legend.enabled = false //チャートの概要の表示可否
        barChartView.xAxis.gridColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3) // 縦グリッドの色
        barChartView.xAxis.gridColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3) // 横グリッドの色
        barChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom // X軸ラベルの位置
        barChartView.rightAxis.enabled = false //右側のY軸目盛り非表示
        barChartView.leftAxis.axisMinimum = 0.0 //左側のY軸目盛り最小値
        barChartView.leftAxis.granularity = 1.0 //左側のY軸目盛りの区切り地
        barChartView.doubleTapToZoomEnabled = false //ダブルタップによるズーム
        barChartView.scaleXEnabled = false //X軸ピンチアウト
        barChartView.scaleYEnabled = false //Y軸ピンチアウト
        barChartView.highlightPerDragEnabled = false //ドラッグによるハイライト線表示
        barChartView.highlightPerTapEnabled = false //タップによるハイライト線表示
        barChartView.animate(yAxisDuration: 0.5) //表示時のアニメーション
        
        // X軸にラベルとして表示する文字列を指定
        let dayStrings = Day.localizedDayStrings()
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:dayStrings)
        barChartView.xAxis.granularity = 1
        
        // BarChartViewにデータをセット
        barChartView.data = barChartData()
        
        // BarChartViewのY軸ラベルの表示範囲上限を設定
        barChartView.leftAxis.axisMaximum = leftAxisMaximum()
        
        return barChartView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.data = barChartData()
        uiView.animate(yAxisDuration: 0.5)
        uiView.leftAxis.axisMaximum = leftAxisMaximum()
    }
    
    func barChartData() -> BarChartData {
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
        barChartDataSet.setColor(UIColor.systemBlue)
        // BarChartDataを生成
        let barChartData = BarChartData()
        barChartData.addDataSet(barChartDataSet)
        barChartData.setDrawValues(false)
        return barChartData
    }
    
    func leftAxisMaximum() -> Double {
        let maxAchievedTodoCount = achievedTodoCounts.max() ?? 0
        if maxAchievedTodoCount > 5 {
            return Double(maxAchievedTodoCount)
        } else {
            return 5.0
        }
    }
}
