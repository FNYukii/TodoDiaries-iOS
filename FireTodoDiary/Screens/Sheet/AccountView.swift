//
//  AccountView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/17.
//

import SwiftUI

struct AccountView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    private let userEmail: String
    @State private var isConfirming = false
    
    init() {
        self.userEmail = CurrentUser.email()
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    HStack {
                        Text("email")
                        Text(userEmail)
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
                    dismiss()
                }
            }
            
            .navigationTitle("account")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("done")
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}
