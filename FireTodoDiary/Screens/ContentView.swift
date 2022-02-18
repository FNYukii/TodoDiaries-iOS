//
//  ContentView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var signInStateViewModel = SignInStateViewModel()
    
    var body: some View {
        
        if !signInStateViewModel.isSignedIn {
            WelcomeView()
        }
        
        if signInStateViewModel.isSignedIn {
            TabView {
                FirstView()
                    .tabItem{
                        Label("todos", systemImage: "checkmark")
                    }
                SecondView()
                    .tabItem {
                        Label("history", systemImage: "calendar")
                    }
                ThirdView()
                    .tabItem {
                        Label("stats", systemImage: "chart.bar.xaxis")
                    }
            }
        }
    }
}
