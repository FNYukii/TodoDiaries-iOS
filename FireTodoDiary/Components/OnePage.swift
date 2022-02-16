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
            let databaseReference = Database
                .database(url: "https://firetododiary-default-rtdb.asia-southeast1.firebasedatabase.app")
                .reference()
                    
            databaseReference
                .child("achievedTodoCounts/helloMan/202201")
                .getData(completion:  { error, snapshot in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    let counts = snapshot.value as? NSArray
                    if let counts = counts {
                        
                        let countsArray = counts as! [Int?]
                        print("now: \(self.showYear) - \(self.showMonth), counts: \(countsArray)")
                    } else {
                        print("counts: nil")
                    }
                })
        }
        
    }
}
