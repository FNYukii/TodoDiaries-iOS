//
//  ThirdView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct ThirdView: View {
    
    var body: some View {
        NavigationView {
            List {
                ChartsSection()
                HighlightsSection()
                Section {
                    NavigationLink(destination: AccountView()) {
                        Text("account")
                    }
                    NavigationLink(destination: TermsView()) {
                        Text("terms")
                    }
                    NavigationLink(destination: PrivacyPolicyView()) {
                        Text("privacy_policy")
                    }
                    NavigationLink(destination: AboutView()) {
                        Text("about_this_app")
                    }
                }
            }
            
            .navigationTitle("stats")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
