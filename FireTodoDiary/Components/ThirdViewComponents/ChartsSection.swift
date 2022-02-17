//
//  ChartsSection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/17.
//

import SwiftUI

struct ChartsSection: View {
    
    @State private var selection = 0
    
    var body: some View {
        Section(header: Text("charts")) {
            TabView(selection: $selection) {
                ForEach(-2 ..< 3){ index in
                    OnePage(monthOffset: index)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 300)
        }
    }
}
