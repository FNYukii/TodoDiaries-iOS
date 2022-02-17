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
    private let localizedYearAndMonth: String
    
    // 表示月の日別Todo達成数 例:[2, 4, 6, 1, 8, 12, 4, 2, ...] 要素数は表示月の日数
    @State private var achievedTodoCounts: [Int] = []
    @State private var isFirstLoading = true
    
    init(monthOffset: Int){
        let shiftedDate = Day.shiftedDate(monthOffset: monthOffset)
        self.showYear = Calendar.current.component(.year, from: shiftedDate)
        self.showMonth = Calendar.current.component(.month, from: shiftedDate)
        self.localizedYearAndMonth = Day.toYearAndMonthString(from: shiftedDate)
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            if isFirstLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            if !isFirstLoading {
                Text(localizedYearAndMonth)
                    .font(.title)
                BarChart(achievedTodoCounts: achievedTodoCounts)
                Spacer()
            }
        }
        .frame(height: 300)
        
        .onAppear {
            // Read achievedTodoCounts
            FirestoreTodo.readAchievedTodoCounts(year: showYear, month: showMonth) { achievedTodoCounts in
                self.achievedTodoCounts = achievedTodoCounts
                isFirstLoading = false
            }
        }
        
    }
}
