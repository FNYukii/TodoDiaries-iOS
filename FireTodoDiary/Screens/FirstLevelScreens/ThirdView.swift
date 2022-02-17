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
                NumbersSection()
            }
            
            .navigationTitle("stats")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ShowAccountViewButton()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
