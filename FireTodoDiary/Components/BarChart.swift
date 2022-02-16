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
        barChartView.legend.enabled = false //チャートの概要非表示
        barChartView.xAxis.gridColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3) // 縦グリッドの色
        barChartView.xAxis.gridColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3) // 横グリッドの色
        barChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        barChartView.rightAxis.enabled = false //右側のY軸目盛り非表示
        barChartView.leftAxis.axisMinimum = 0.0 //左側のY軸目盛り最小値
        barChartView.leftAxis.granularity = 1.0 //左側のY軸目盛りの区切り地
        barChartView.doubleTapToZoomEnabled = false //ダブルタップによるズームを無効
        barChartView.scaleXEnabled = false //X軸ピンチアウトを無効
        barChartView.scaleYEnabled = false //Y軸ピンチアウトを無効
        barChartView.highlightPerDragEnabled = false //ドラッグによるハイライト線表示を無効
        barChartView.highlightPerTapEnabled = false //タップによるハイライト線表示を無効
        // X軸にラベルとして表示する文字列を指定
        let dayStrings = ["1日", "2日", "3日", "4日", "5日", "6日", "7日", "８日", "9日", "10日", "11日", "12日", "13日", "14日"]
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:dayStrings)
        barChartView.xAxis.granularity = 1
        
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
        barChartDataSet.setColor(UIColor.systemBlue)

        // BarChartDataを生成
        let barChartData = BarChartData()
        barChartData.addDataSet(barChartDataSet)
        barChartData.setDrawValues(false)

        // BarChartViewにデータをセット
        uiView.data = barChartData
        
        // BarChartViewのY軸ラベルの表示範囲上限を設定
        let maxAchievedTodoCount = achievedTodoCounts.max() ?? 0
        if(maxAchievedTodoCount > 5){
            uiView.leftAxis.axisMaximum = Double(maxAchievedTodoCount)
        } else {
            uiView.leftAxis.axisMaximum = 5.0
        }
    }
}
