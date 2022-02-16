//
//  OnePage.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/16.
//

import SwiftUI
import Firebase
import FirebaseDatabase

struct OnePage: View {
    
    private let showYear: Int
    private let showMonth: Int
    
    // 表示月の日別Todo達成数 例:[2, 4, 6, 1, 8, 12, 4, 2, ...] 要素数は表示月の日数
    @State private var achievedTodoCounts: [Int] = []
    
    init(monthOffset: Int){
        let date = Day.shiftedDate(monthOffset: monthOffset)
        self.showYear = Calendar.current.component(.year, from: date)
        self.showMonth = Calendar.current.component(.month, from: date)
    }
    
    var body: some View {
        
        VStack {
            Text("\(showYear)年 \(showMonth)月")
            LineChart(achievedTodoCounts: achievedTodoCounts)
        }
        
        .onAppear {
            // Read achievedTodoCounts
            RealtimeDB.readAchievedTodoCounts(showYear: showYear, showMonth: showMonth) { achievedTodoCounts in
                self.achievedTodoCounts = achievedTodoCounts
            }
        }
        
    }
}
