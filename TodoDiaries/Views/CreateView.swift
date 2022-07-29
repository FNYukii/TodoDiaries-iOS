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
    
    // Loadings
    @State private var isLoading = false
    @State private var isShowDialogError = false
    
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
            
            .alert("failed", isPresented: $isShowDialogError) {
                Button("ok") {
                    isShowDialogError = false
                }
            } message: {
                Text("todo_creation_failed")
            }
            
            .navigationTitle("new_todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel"){
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .primaryAction) {
                    // Create Button
                    if !isLoading {
                        Button(action: {
                            isLoading = true
                            FireTodo.createTodo(content: content, isPinned: isPinned, achievedAt: isAchieved ? achievedAt : nil) { documentId in
                                // 失敗
                                if documentId == nil {
                                    isLoading = false
                                    isShowDialogError = true
                                    return
                                }
                                
                                // 成功
                                dismiss()
                            }
                        }){
                            Text("add")
                                .fontWeight(.bold)
                        }
                        .disabled(content.isEmpty)
                    }
                    
                    // Progress View
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                }
            }
        }
    }
}
