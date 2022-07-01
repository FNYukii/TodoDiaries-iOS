//
//  FirebaseUIView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import SwiftUI
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseOAuthUI

struct FirebaseAuthView: UIViewControllerRepresentable {
    
    class Coordinator: NSObject, FUIAuthDelegate {
        
        let parent: FirebaseAuthView
        
        init(_ parent: FirebaseAuthView) {
            self.parent = parent
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        
        // Get FirebaseUI
        let authUI = FUIAuth.defaultAuthUI()!
        authUI.providers = [
            FUIGoogleAuth(authUI: authUI),
            FUIOAuth.appleAuthProvider(withAuthUI: authUI),
            FUIOAuth.twitterAuthProvider(withAuthUI: authUI),
            FUIOAuth.githubAuthProvider(withAuthUI: authUI),
        ]
        
        // Show FirebaseUI
        let authViewController = authUI.authViewController()
        return authViewController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // Do nothing
    }
    
}
