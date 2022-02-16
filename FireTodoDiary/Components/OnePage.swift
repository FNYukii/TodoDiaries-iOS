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
    @State private var isLoading = false
    
    init(monthOffset: Int){
        let date = Day.shiftedDate(monthOffset: monthOffset)
        self.showYear = Calendar.current.component(.year, from: date)
        self.showMonth = Calendar.current.component(.month, from: date)
    }
    
    var body: some View {
        
        ZStack {
            
            VStack {
                Text("\(showYear)年 \(showMonth)月")
                LineChart(achievedTodoCounts: achievedTodoCounts)
                    .frame(height: 300)
                Spacer()
            }
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        
        .onAppear {
            // Read achievedTodoCounts
            isLoading = true
            FirestoreTodo.readAchievedTodoCounts(year: showYear, month: showMonth) { achievedTodoCounts in
                self.achievedTodoCounts = achievedTodoCounts
                isLoading = false
            }
        }
        
    }
}
