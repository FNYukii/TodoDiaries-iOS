//
//  CreateTodoView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct CreateTodoView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var content = ""
    @State var isPinned = false
    @State var isAchieved = false
    @State var achievedAt: Date = Date()
    
    var body: some View {
        NavigationView {
            
            Form {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $content)
                    Text("やること")
                        .foregroundColor(Color(UIColor.placeholderText))
                        .opacity(content.isEmpty ? 1 : 0)
                        .padding(.top, 8)
                        .padding(.leading, 5)
                }
                
                Section {
                    Toggle("Todoを固定", isOn: $isPinned)
                    Toggle("達成済み", isOn: $isAchieved.animation())
                    
                    if isAchieved {
                        DatePicker("達成日時", selection: $achievedAt)
                    }
                }
            }
            
            // Navigation Bar
            .navigationBarTitle("新規Todo", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        // TODO: Add new todo to Clud Firestore
                        dismiss()
                    }){
                        Text("追加")
                            .fontWeight(.bold)
                    }
                }
            }
            
        }
    }
}
