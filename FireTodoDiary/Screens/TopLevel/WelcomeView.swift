//
//  WelcomeView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var isShowSheet = false
    @State private var selection = 0
    
    var body: some View {
        
        TabView(selection: $selection) {
            VStack {
                Text("Todoを追加しましょう")
            }
            .tag(0)
            VStack {
                Text("Todoを達成し、履歴を振り返りましょう")
            }
            .tag(1)
            VStack {
                Text("統計情報を見ることもできます")
                Button("sign_in_to_start") {
                    isShowSheet.toggle()
                }
                .buttonStyle(BorderedProminentButtonStyle())
            }
            .tag(2)

        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        
        .sheet(isPresented: $isShowSheet) {
            FirebaseAuthView()
        }
        
    }
}
