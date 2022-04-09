//
//  ThirdView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct ThirdView: View {
    
    var body: some View {
        NavigationView {
            List {
                ChartsSection()
                HighlightsSection()
                Section {
                    NavigationLink(destination: SettingsView()) {
                        Text("settings")
                    }
                }
            }
            
            .navigationTitle("stats")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
