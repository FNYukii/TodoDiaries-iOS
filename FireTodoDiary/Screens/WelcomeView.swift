//
//  WelcomeView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import SwiftUI

struct WelcomeView: View {
    
    @State var isShowSheet = false
    
    var body: some View {
        VStack {
            Text("Welcome to Todo Diary")
            Button("Sign in") {
                isShowSheet.toggle()
            }
        }
        
        .sheet(isPresented: $isShowSheet) {
            FirebaseAuthView(isShowSheet: $isShowSheet)
        }
        
    }
}
