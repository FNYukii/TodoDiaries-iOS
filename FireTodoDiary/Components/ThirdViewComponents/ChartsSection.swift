//
//  ChartsSection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/17.
//

import SwiftUI

struct ChartsSection: View {
    
    @State private var pageSelection = 0
    @State private var typeSelection = 0
    
    var body: some View {
        Section(header: Text("charts")) {
            
            Picker(selection: $typeSelection, label: Text("picker")) {
                Text("日")
                    .tag(0)
                Text("月")
                    .tag(1)
                Text("年")
                    .tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .listRowSeparator(.hidden)
            
            TabView(selection: $pageSelection.animation()) {
                ForEach(-2 ..< 3){ index in
                    if typeSelection == 0 {
                        DayChartPage(pageOffset: index)
                            .tag(index)
                    } else if typeSelection == 1 {
                        MonthChartPage(pageOffset: index)
                            .tag(index)
                    } else if typeSelection == 2 {
                        YearChartPage(pageOffset: index)
                            .tag(index)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 300)
        }
    }
}
