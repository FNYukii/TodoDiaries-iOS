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
        
        VStack {
            TabView(selection: $selection.animation()) {
                VStack {
                    Image(decorative: "image01")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                    Text("Todoを追加しましょう")
                }
                .tag(0)
                VStack {
                    Image(decorative: "image02")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                    Text("Todoを達成し、履歴を振り返りましょう")
                }
                .tag(1)
                VStack {
                    Image(decorative: "image03")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                    Text("統計情報を見ることもできます")
                }
                .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .frame(height: 400)
            
            Button(action: {
                isShowSheet.toggle()
            }) {
                Text("sign_in_to_start")
                    .font(.title3)
            }
            .buttonStyle(BorderedProminentButtonStyle())
        }
        
        .sheet(isPresented: $isShowSheet) {
            FirebaseAuthView()
        }
        
    }
}
