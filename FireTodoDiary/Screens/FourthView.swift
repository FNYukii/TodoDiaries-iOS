//
//  FourthView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import SwiftUI
import FirebaseAuth
import Firebase

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
                        Text(String(todoCount))
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("achievements")
                        Spacer()
                        Text(String(achievementCount))
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
            
            .navigationBarTitle("profile")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        .onAppear {
                        
            // Read user email
            let userEmail = Auth.auth().currentUser?.email
            if let userEmail = userEmail {
                self.userEmail = userEmail
            }
            
            // User id
            var userId = ""
            let user = Auth.auth().currentUser
            if let user = user {
                userId = user.uid
            }
            
            // Read unachieved todo count
            let db = Firestore.firestore()
            db.collection("todos")
                .whereField("userId", isEqualTo: userId)
                .whereField("isAchieved", isEqualTo: false)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("HELLO! Fail! Error getting documents: \(err)")
                        return
                    }
                    print("HELLO! Success! Read documents in todos")
                    if let querySnapshot = querySnapshot {
                        todoCount = querySnapshot.documents.count
                    }
            }
            
            // Read achieved todo count
            db.collection("todos")
                .whereField("userId", isEqualTo: userId)
                .whereField("isAchieved", isEqualTo: true)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("HELLO! Fail! Error getting documents: \(err)")
                        return
                    }
                    print("HELLO! Success! Read documents in todos")
                    if let querySnapshot = querySnapshot {
                        achievementCount = querySnapshot.documents.count
                    }
            }
        }
        
    }
}
