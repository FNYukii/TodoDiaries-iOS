//
//  ChartsSection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/17.
//

import SwiftUI

struct AchieveCountsAtMonthSection: View {
    
    @State private var pageSelection = 0
    
    var body: some View {
        Section {
            
            TabView(selection: $pageSelection) {
                ForEach(-50 ..< 51){ index in
                    AchieveCountsAtMonthPage(pageOffset: index)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 300)
        }
    }
}
