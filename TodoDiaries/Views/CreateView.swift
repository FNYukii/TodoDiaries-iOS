//
//  CreateTodoView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI
import Introspect

struct CreateView: View {
    
    // Environments
    @Environment(\.dismiss) private var dismiss
    
    // States
    @State private var content = ""
    @State private var isPinned = false
    @State private var achievedAt: Date = Date()
    
    @State private var isAchieved = false
    
    var body: some View {
        NavigationView {
            
            Form {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $content)
                        .frame(height: 80)
                        .introspectTextView { textEditor in
                            textEditor.becomeFirstResponder()
                        }
                    Text("todo")
                        .foregroundColor(Color(UIColor.placeholderText))
                        .opacity(content.isEmpty ? 1 : 0)
                        .padding(.top, 8)
                        .padding(.leading, 5)
                }
                
                Section {
                    // ピン留め切り替え
                    Toggle("pin", isOn: $isPinned)
                        .disabled(isAchieved)
                    // 達成切り替え
                    Toggle("make_achieved", isOn: $isAchieved.animation())
                        .onChange(of: isAchieved) { value in
                            if isAchieved {
                                withAnimation {
                                    isPinned = false
                                }
                            }
                        }
                    // DatePicker
                    if isAchieved {
                        DatePicker("achieved_at", selection: $achievedAt)
                    }
                }
            }
            
            .navigationTitle("new_todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        FireTodo.createTodo(content: content, isPinned: isPinned, achievedAt: isAchieved ? achievedAt : nil) { documentId in
                            // Do nothing
                        }
                        dismiss()
                    }){
                        Text("add")
                            .fontWeight(.bold)
                    }
                    .disabled(content.isEmpty)
                }
            }
        }
    }
}
