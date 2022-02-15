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
    
    @State private var isConfirming = false
    
    var body: some View {
        NavigationView {
            Form {
                
                ScrollView(.horizontal) {
                    HStack {
                        Text("email")
                        Spacer()
                        Text(userEmail)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
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
                    isConfirming.toggle()
                }
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            
            .confirmationDialog("areYouSureYouWantToSignOut", isPresented: $isConfirming, titleVisibility: .visible) {
                Button("signOut", role: .destructive) {
                    do {
                        try Auth.auth().signOut()
                    } catch {
                        print("HELLO! Fail! Error signing out")
                    }
                }
            }
            
            .navigationBarTitle("account")
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
