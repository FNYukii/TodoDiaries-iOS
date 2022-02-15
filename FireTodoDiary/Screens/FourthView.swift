//
//  FourthView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import SwiftUI
import FirebaseAuth

struct FourthView: View {
    
    @State private var userEmail = ""
    @State private var todoCount = 0
    @State private var achievementCount = 0
    
    var body: some View {
        NavigationView {
            Form {
                
                HStack {
                    Text("email")
                    Spacer()
                    Text(userEmail)
                        .foregroundColor(.secondary)
                }
                
                Section(header: Text("stats")) {
                    HStack {
                        Text("todos")
                        Spacer()
                        Text("5")
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("achievements")
                        Spacer()
                        Text("23")
                            .foregroundColor(.secondary)
                    }
                }
                
                Button("signOut") {
                    do {
                        try Auth.auth().signOut()
                    } catch {
                        print("HELLO! Fail! Error signing out")
                    }
                }
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            
            .navigationBarTitle("profile")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        .onAppear {
            let userEmail = Auth.auth().currentUser?.email
            if let userEmail = userEmail {
                self.userEmail = userEmail
            }
        }
        
    }
}
