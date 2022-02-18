//
//  HorizontalBarChart.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/18.
//

import SwiftUI
import Charts

struct HorizontalBarChart: UIViewRepresentable {
    
    let value0: Double
    let value1: Double
    let xAxixLabels: [String]
    
    func makeUIView(context: Context) -> HorizontalBarChartView  {
        // HorizontalBarChartViewを生成
        let horizontalBarChartView = HorizontalBarChartView()
        
        // HorizontalBarChartViewをスタイリング
        horizontalBarChartView.legend.enabled = false //チャートの概要の表示可否
        horizontalBarChartView.xAxis.gridColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3) // 縦グリッドの色
        horizontalBarChartView.xAxis.gridColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3) // 横グリッドの色
        
        horizontalBarChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom // X軸ラベルの位置を右から左へ
        horizontalBarChartView.leftAxis.enabled = false // 上側Y軸のラベル
        horizontalBarChartView.rightAxis.axisMinimum = 0.0 // 下側Y軸の目盛り最小値
        horizontalBarChartView.rightAxis.granularity = 1.0 // 下側Y軸の目盛りの粒度
        
        horizontalBarChartView.doubleTapToZoomEnabled = false //ダブルタップによるズーム
        horizontalBarChartView.scaleXEnabled = false //X軸ピンチアウト
        horizontalBarChartView.scaleYEnabled = false //Y軸ピンチアウト
        horizontalBarChartView.highlightPerDragEnabled = false //ドラッグによるハイライト線表示
        horizontalBarChartView.highlightPerTapEnabled = false //タップによるハイライト線表示
        horizontalBarChartView.animate(yAxisDuration: 0.5) //表示時のアニメーション
        
        // X軸にラベルとして表示する文字列を指定
        horizontalBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxixLabels)
        horizontalBarChartView.xAxis.granularity = 1 // X軸の目盛りの粒度
        
        // Y軸の最大値を設定
        horizontalBarChartView.rightAxis.axisMaximum = rightAxisMaximum()
        
        // HorizontalBarChartViewにデータをセット
        horizontalBarChartView.data = barChartData()
        
        return horizontalBarChartView
    }
    
    func updateUIView(_ uiView: HorizontalBarChartView, context: Context) {
        uiView.data = barChartData()
        uiView.animate(yAxisDuration: 0.5)
        uiView.rightAxis.axisMaximum = rightAxisMaximum()
    }
    
    private func barChartData() -> BarChartData {
        // BarChartDataEntryを生成
        var barChartDataEntries : [BarChartDataEntry] = []
        barChartDataEntries.append(BarChartDataEntry(x: 0.0, y: value0))
        barChartDataEntries.append(BarChartDataEntry(x: 1.0, y: value1))
        print("enties: \(barChartDataEntries)")
        
        // BarChartDataSetを生成
        let barChartDataSet = BarChartDataSet(barChartDataEntries)
        barChartDataSet.colors = [UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5) , UIColor.systemBlue] // 棒の色
        // BarChartDataを生成
        let barChartData = BarChartData()
        barChartData.addDataSet(barChartDataSet)
        barChartData.setDrawValues(false) // 棒の右の値
        barChartData.barWidth = 0.5 // 棒の幅
        return barChartData
    }
    
    private func rightAxisMaximum() -> Double {
        let maxCountOfTodoAchieved = [value0, value1].max() ?? 0
        if maxCountOfTodoAchieved > 5 {
            return Double(maxCountOfTodoAchieved)
        } else {
            return 5.0
        }
    }
}
