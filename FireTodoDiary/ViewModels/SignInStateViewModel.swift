//
//  AuthStateViewModel.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import FirebaseAuth

class SignInStateViewModel: ObservableObject {
    
    @Published var isSignedIn: Bool = false
    @Published var isLoaded = false
    
    private var handle: AuthStateDidChangeListenerHandle!
    
    init() {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.isSignedIn = true
            } else {
                self.isSignedIn = false
            }
            self.isLoaded = true
        }
    }
    
    deinit {
        Auth.auth().removeStateDidChangeListener(handle)
    }
}
