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
                        Label("todos", systemImage: "list.bullet")
                    }
                SecondView()
                    .tabItem {
                        Label("achievements", systemImage: "checkmark")
                    }
                ThirdView()
                    .tabItem {
                        Label("calendar", systemImage: "calendar")
                    }
                FourthView()
                    .tabItem {
                        Label("account", systemImage: "person")
                    }
            }
        }
    }
}
