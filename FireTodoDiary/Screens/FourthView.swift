//
//  FourthView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import SwiftUI
import FirebaseAuth

struct FourthView: View {
    var body: some View {
        NavigationView {
            Button("signOut") {
                do {
                    try Auth.auth().signOut()
                } catch {
                    print("HELLO! Fail! Error signing out")
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
