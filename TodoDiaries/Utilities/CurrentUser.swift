//
//  CurrentUser.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import Foundation
import FirebaseAuth

class CurrentUser {
    
    static func userId() -> String {
        let user = Auth.auth().currentUser
        if let user = user {
            return user.uid
        }
        return ""
    }
    
    static func email() -> String {
        let email = Auth.auth().currentUser?.email
        if let email = email {
            return email
        }
        return ""
    }
    
    static func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("HELLO! Fail! Error signing out")
        }
    }
}
