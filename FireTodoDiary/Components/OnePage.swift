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
        let yearAndMonth = Day.yearAndMonth(monthOffset: monthOffset)
        self.showYear = yearAndMonth[0]
        self.showMonth = yearAndMonth[1]
    }
    
    var body: some View {
        Text("\(showYear)年 \(showMonth)月")
    }
}
