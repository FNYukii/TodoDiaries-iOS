//
//  ChartsSection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/17.
//

import SwiftUI

struct ChartsSection: View {
    
    @State private var pageSelection = 0
    @State private var chartTypeSelection = 0
    
    var body: some View {
        Section(header: Text("charts")) {
            
            Picker(selection: $chartTypeSelection, label: Text("picker")) {
                Text("日")
                    .tag(0)
                Text("月")
                    .tag(1)
                Text("年")
                    .tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .listRowSeparator(.hidden)
            
            TabView(selection: $pageSelection) {
                ForEach(-2 ..< 3){ index in
                    MonthChartPage(monthOffset: index)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 300)
        }
    }
}
