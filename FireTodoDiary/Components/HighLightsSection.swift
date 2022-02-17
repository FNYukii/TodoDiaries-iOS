//
//  HighLightsSection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/17.
//

import SwiftUI

struct HighLightsSection: View {
    
    @State private var unachievedTodoCount = 0
    @State private var achievedTodoCount = 0
    
    var body: some View {
        Section(header: Text("highlights")) {
            HStack {
                Text("todos")
                Spacer()
                Text(String(unachievedTodoCount))
                    .foregroundColor(.secondary)
            }
            HStack {
                Text("achievements")
                Spacer()
                Text(String(achievedTodoCount))
                    .foregroundColor(.secondary)
            }
        }
        
        .onAppear {
            // Read unachieved todo count
            FirestoreTodo.readCount(isAchieved: false) {count in
                unachievedTodoCount = count
            }
            // Read unachieved todo count
            FirestoreTodo.readCount(isAchieved: true) {count in
                achievedTodoCount = count
            }
        }
        
    }
}
