//
//  FireTodoDiaryApp.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI
import Firebase

@main
struct FireTodoDiaryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Connect to Firebase
        FirebaseApp.configure()
        
        return true
    }
}
