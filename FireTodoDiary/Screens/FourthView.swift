//
//  FourthView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import SwiftUI

struct FourthView: View {
    
    @State private var userEmail = ""
    @State private var unachievedTodoCount = 0
    @State private var achievedTodoCount = 0
    
    @State private var isConfirming = false
    
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
                        Text(String(unachievedTodoCount))
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("achievements")
                        Spacer()
                        Text(String(achievedTodoCount))
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
                    CurrentUser.signOut()
                }
            }
            
            .navigationBarTitle("profile")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        .onAppear {
            // Read user email
            userEmail = CurrentUser.email()
            
            // Read unachieved todo count
            TodoDocument.readCount(isAchieved: false) {count in
                unachievedTodoCount = count
            }
            
            // Read unachieved todo count
            TodoDocument.readCount(isAchieved: true) {count in
                achievedTodoCount = count
            }
        }
        
    }
}
