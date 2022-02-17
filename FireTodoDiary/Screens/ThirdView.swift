//
//  ThirdView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct ThirdView: View {

    @State private var isShowAccountSheet = false
        
    var body: some View {
        NavigationView {
            List {
                ChartsSection()
                HighLightsSection()
            }
            
            .sheet(isPresented: $isShowAccountSheet) {
                AccountView()
            }
            
            .navigationTitle("stats")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isShowAccountSheet.toggle()
                    }) {
                        Image(systemName: "person.crop.circle")
                            .font(.title2)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
