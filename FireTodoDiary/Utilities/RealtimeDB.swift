//
//  RealtimeDB.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/16.
//

import FirebaseDatabase

class RealtimeDB {
    
    static func readAchievedTodoCounts(showYear: Int, showMonth: Int, completion: (([Int]) -> Void)?) {
        // 表示月の年と月を連結
        let yyyyMm = showYear * 100 + showMonth
        print("yyyyMn: \(yyyyMm)")
        
//        let userId = CurrentUser.userId()
        let userId = "helloMan"
        
        // Realtime Databaseから読み取り
        Database.database(url: "https://firetododiary-default-rtdb.asia-southeast1.firebasedatabase.app")
            .reference()
            .child("achievedTodoCounts/\(userId)/\(yyyyMm)")
            .getData(completion:  { error, snapshot in
                if error != nil {
                    print("HELLO! Fail! Error reading /achievedTodoCounts/\(userId)/\(yyyyMm)")
                    completion?([])
                }
                print("HELLO! Success! Read /achievedTodoCounts/\(userId)/\(yyyyMm)")
                
                // オプショナル型のachievedTodoCountsを生成
                let countsNSArray = snapshot.value as? NSArray ?? []
                var oAchievedTodoCounts = countsNSArray as! [Int?]
                
                // 表示月の日数
                let dayCount = Day.dayCountAtTheMonth(year: showYear, month: showMonth)
                
                // 要素数を表示月の日数に合わせる
                while oAchievedTodoCounts.count < dayCount {
                    oAchievedTodoCounts.append(nil)
                }
                
                // 配列内のnilを0に置き換える
                for index in 0 ..< oAchievedTodoCounts.count {
                    if oAchievedTodoCounts[index] == nil {
                        oAchievedTodoCounts[index] = 0
                    }
                }
                
                // 非オプショナル型に変換
                let achievedTodoCounts = oAchievedTodoCounts as! [Int]                
                completion?(achievedTodoCounts)
            })
    }
    
}
