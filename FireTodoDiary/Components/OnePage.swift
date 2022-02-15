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
        self.showYear = Day.shiftedYear(monthOffset: monthOffset)
        self.showMonth = Day.shiftedMonth(monthOffset: monthOffset)
    }
    
    var body: some View {
        Text("\(showYear)年 \(showMonth)月")
    }
}
