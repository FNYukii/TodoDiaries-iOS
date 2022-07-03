//
//  AccountView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/04/10.
//

import SwiftUI

struct AccountView: View {
    private let userEmail: String
    @State private var isConfirming = false
    
    init() {
        self.userEmail = FireAuth.email()
    }
    
    var body: some View {
        Form {
            
            Section {
                HStack {
                    Text("email")
                    Spacer()
                    Text(userEmail)
                        .foregroundColor(.secondary)
                }
            }
            
            Button("sign_out") {
                isConfirming.toggle()
            }
            .foregroundColor(.red)
            .frame(maxWidth: .infinity, alignment: .center)
            .confirmationDialog("are_you_sure_you_want_to_sign_out", isPresented: $isConfirming, titleVisibility: .visible) {
                Button("sign_out", role: .destructive) {
                    FireAuth.signOut()
                }
            }
        }
        
        .navigationTitle("account")
        .navigationBarTitleDisplayMode(.inline)
    }
}
