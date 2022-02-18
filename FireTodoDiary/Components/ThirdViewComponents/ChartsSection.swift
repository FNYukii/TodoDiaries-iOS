//
//  ChartsSection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/17.
//

import SwiftUI

struct ChartsSection: View {
    
    @State private var pageSelection = 0
    @State private var unitSelection = 0
    
    var body: some View {
        Section(header: Text("achievedTodos")) {
            
            Picker(selection: $unitSelection, label: Text("picker")) {
                Text("d")
                    .tag(0)
                Text("m")
                    .tag(1)
                Text("y")
                    .tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .listRowSeparator(.hidden)
            
            TabView(selection: $pageSelection) {
                ForEach(-10 ..< 11){ index in
                    ChartPage(pageOffset: index, unitSelection: $unitSelection)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 300)
        }
    }
}
