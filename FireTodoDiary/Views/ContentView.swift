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
                    Label("todos", systemImage: "list.bullet")
                }
            SecondView()
                .tabItem {
                    Label("achieved", systemImage: "checkmark")
                }
            ThirdView()
                .tabItem {
                    Label("achievementGraph", systemImage: "chart.xyaxis.line")
                }
        }
    }
}
