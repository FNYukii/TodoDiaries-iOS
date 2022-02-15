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
            
            TabView() {
                ForEach(-5..<6){ index in
                    Text("\(index)")
                }
            }
            .tabViewStyle(PageTabViewStyle())
            
            .navigationTitle("calendar")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
