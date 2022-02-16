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
    
    private var achievedTodoCounts: [Int] = []
    
    init(monthOffset: Int){
        let date = Day.shiftedDate(monthOffset: monthOffset)
        self.showYear = Calendar.current.component(.year, from: date)
        self.showMonth = Calendar.current.component(.month, from: date)
        
        let ref: DatabaseReference = Database.database().reference()
        
    }
    
    var body: some View {
        
        VStack {
            Text("\(showYear)年 \(showMonth)月")
            LineChart(showYear: showYear, showMonth: showMonth)
        }
        
        
    }
}
