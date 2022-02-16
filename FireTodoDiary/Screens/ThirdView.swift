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
            List {
                
                Section(header: Text("achievements")) {
                    TabView(selection: $selection) {
                        ForEach(-2 ..< 3){ index in
                            OnePage(monthOffset: index)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 400)
                }
                
            }
            
            .navigationTitle("charts")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
