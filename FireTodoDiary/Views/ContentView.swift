//
//  ContentView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            FirstView()
                .tabItem{
                    Label("Todo", systemImage: "list.bullet")
                }
            SecondView()
                .tabItem {
                    Label("達成済み", systemImage: "checkmark")
                }
            ThirdView()
                .tabItem {
                    Label("達成グラフ", systemImage: "chart.xyaxis.line")
                }
        }
    }
}
