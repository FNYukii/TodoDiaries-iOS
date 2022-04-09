//
//  AccountView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/17.
//

import SwiftUI

struct SettingsView: View {
        
    private let userEmail: String
    @State private var isConfirming = false
    
    init() {
        self.userEmail = CurrentUser.email()
    }
    
    var body: some View {
        Form {
            
            Section(header: Text("account")) {
                HStack {
                    Text("email")
                    Spacer()
                    Text(userEmail)
                        .foregroundColor(.secondary)
                }
            }
            
            Button("signOut") {
                isConfirming.toggle()
            }
            .foregroundColor(.red)
            .frame(maxWidth: .infinity, alignment: .center)
            .confirmationDialog("areYouSureYouWantToSignOut", isPresented: $isConfirming, titleVisibility: .visible) {
                Button("signOut", role: .destructive) {
                    CurrentUser.signOut()
                }
            }
        }
        
        .navigationTitle("settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}
