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
    
    @State private var achievedTodoCounts: [Int] = []
    
    init(monthOffset: Int){
        let date = Day.shiftedDate(monthOffset: monthOffset)
        self.showYear = Calendar.current.component(.year, from: date)
        self.showMonth = Calendar.current.component(.month, from: date)
    }
    
    var body: some View {
        
        VStack {
            Text("\(showYear)年 \(showMonth)月")
//            LineChart(showYear: showYear, showMonth: showMonth)
        }
        
        .onAppear {
            // 表示月の年と月を連結
            let yyyyMm = showYear * 100 + showMonth
            print("yyyyMn: \(yyyyMm)")
            
            // Realtime Databaseから読み取り
            Database.database(url: "https://firetododiary-default-rtdb.asia-southeast1.firebasedatabase.app")
                .reference()
                .child("achievedTodoCounts/helloMan/\(yyyyMm)")
                .getData(completion:  { error, snapshot in
                    if error != nil {
                        print("HELLO! Fail! Error reading /achievedTodoCounts/helloMan/\(yyyyMm)")
                        return
                    }
                    print("HELLO! Success! Read /achievedTodoCounts/helloMan/\(yyyyMm)")
                    
                    // achievedTodoCountsを生成
                    let countsNSArray = snapshot.value as? NSArray ?? []
                    var achievedTodoCounts = countsNSArray as! [Int?]
                    
                    // 表示月の日数
                    let dayCount = Day.dayCountAtTheMonth(year: showYear, month: showMonth)
                    
                    // 要素数を表示月の日数に合わせる
                    while achievedTodoCounts.count < dayCount {
                        achievedTodoCounts.append(nil)
                    }
                    
                    // 配列内のnilを0に置き換える
                    for index in 0 ..< achievedTodoCounts.count {
                        if achievedTodoCounts[index] == nil {
                            achievedTodoCounts[index] = 0
                        }
                    }
                    
                    // プロパティに適用
                    self.achievedTodoCounts = achievedTodoCounts as! [Int]
                    print("now: \(yyyyMm) counts: \(self.achievedTodoCounts)")
                })
        }
        
    }
}
