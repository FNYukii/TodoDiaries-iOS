//
//  AboutView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/04/10.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        
        List {
            Section(footer: Text("Copyright 2022 Yu357.")) {
                HStack {
                    Image("appIcon")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                    Text("todo-diaries")
                    Text("Version 0.8.2")
                        .foregroundColor(.secondary)                    
                }
            }
        }
        
        .navigationTitle("about_this_app")
        .navigationBarTitleDisplayMode(.inline)
    }
}
