//
//  ChartsSection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/17.
//

import SwiftUI

struct ChartsSection: View {
    
    @State private var pageSelection = 0
    @State private var unitSelection = UserDefaults.standard.integer(forKey: "unitSelection")
    
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
                ForEach(-50 ..< 51){ index in
                    ChartPage(pageOffset: index, unitSelection: $unitSelection)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 300)
        }
        
        .onChange(of: unitSelection) { value in
            UserDefaults.standard.set(value, forKey: "unitSelection")
            pageSelection = 0
        }
    }
}
