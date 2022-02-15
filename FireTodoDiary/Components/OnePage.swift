//
//  OnePage.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/16.
//

import SwiftUI

struct OnePage: View {
    
    private let showYear: Int
    private let showMonth: Int
    
    init(monthOffset: Int){
        // 現在の年と月を取得
        let now = Date()
        var year = Calendar.current.component(.year, from: now)
        var month = Calendar.current.component(.month, from: now)
        
        // monthOffsetの数だけ次の月へ進む
        if monthOffset > 0 {
            for _ in 0 ..< monthOffset {
                if month == 12 {
                    month = 1
                    year += 1
                } else {
                    month += 1
                }
            }
        }
        
        // offsetの数だけ前の月へ戻る
        if monthOffset < 0 {
            let absoluteMonthOffset = -monthOffset
            for _ in 0 ..< absoluteMonthOffset {
                if month == 1 {
                    month = 12
                    year -= 1
                } else {
                    month -= 1
                }
            }
        }
        
        // プロパティへ適用
        self.showYear = year
        self.showMonth = month
    }
    
    var body: some View {
        Text("\(showYear)年 \(showMonth)月")
    }
}
