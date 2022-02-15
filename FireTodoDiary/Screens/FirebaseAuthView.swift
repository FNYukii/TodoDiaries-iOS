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
    
    @Binding var isShowSheet: Bool

    class Coordinator: NSObject, FUIAuthDelegate {
        
        let parent: FirebaseAuthView

        init(_ parent: FirebaseAuthView) {
            self.parent = parent
        }
        
        // Authentication done
        func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
            if let error = error {
                print("HELLO! Fail! Error Signing in \(error.localizedDescription)")
            }
            if let _ = user {
                print("HELLO! Success! Signed in")
                parent.isShowSheet.toggle()
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UINavigationController {
        
        let authUI = FUIAuth.defaultAuthUI()!
        authUI.delegate = context.coordinator
        
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(authUI: authUI),
            FUIOAuth.appleAuthProvider()
        ]
        authUI.providers = providers
        
        // Show FirebaseUI
        let authViewController = authUI.authViewController()
        return authViewController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // Do nothing
    }
    
}
