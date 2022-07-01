//
//  CreateTodoView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI
import Introspect

struct CreateView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var content = ""
    @State private var isPinned = false
    @State private var isAchieved = false
    @State private var achievedAt: Date = Date()
    
    @State private var isSended = false
    
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
                    Toggle("makeAchieved", isOn: $isAchieved.animation())
                        .onChange(of: isAchieved) { value in
                            if isAchieved {
                                withAnimation {
                                    isPinned = false
                                }
                            }
                        }
                    // DatePicker
                    if isAchieved {
                        DatePicker("achievedAt", selection: $achievedAt)
                    }
                }
            }
            
            .navigationTitle("newTodo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        FireTodo.createTodo(content: content, isPinned: isPinned, isAchieved: isAchieved, achievedAt: achievedAt)
                        isSended = true
                        dismiss()
                    }){
                        Text("add")
                            .fontWeight(.bold)
                    }
                    .disabled(content.isEmpty || isSended)
                }
            }
        }
    }
}
