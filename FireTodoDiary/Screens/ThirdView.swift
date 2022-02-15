//
//  ThirdView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct ThirdView: View {
    
    @State private var selection = 0
        
    var body: some View {
        NavigationView {
            
            TabView(selection: $selection) {
                ForEach(-50 ..< 51){ index in
                    OnePage(monthOffset: index)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            
            .navigationTitle("calendar")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
