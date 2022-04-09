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
                
                Section(header: Text("settings")) {
                    NavigationLink(destination: AccountView()) {
                        Text("account")
                    }
                }
            }
            
            .navigationTitle("stats")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
