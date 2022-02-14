//
//  CreateTodoView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI
import Introspect

struct CreateTodoView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var content = ""
    @State private var isPinned = false
    @State private var isAchieved = false
    @State private var achievedAt: Date = Date()
    
    var body: some View {
        NavigationView {
            
            Form {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $content)
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
                    Toggle("pin", isOn: $isPinned)
                    Toggle("makeAchieved", isOn: $isAchieved.animation())
                    if isAchieved {
                        DatePicker("achievedAt", selection: $achievedAt)
                            .environment(\.locale, Locale(identifier: "ja_JP"))
                    }
                }
            }
            
            .navigationBarTitle("newTodo", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        TodoViewModel.create(content: content, isPinned: isPinned, isAchieved: isAchieved, achievedAt: achievedAt)
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
