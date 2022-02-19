//
//  EditTodoView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct EditTodoView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let id: String
    @State private var content: String
    @State private var isPinned: Bool
    @State private var isAchieved: Bool
    @State private var achievedAt: Date
    private let oldIsPinned: Bool
    private let oldIsAchieved: Bool
    
    @State private var isConfirming = false
    
    init(todo: Todo) {
        self.id = todo.id
        _content = State(initialValue: todo.content)
        _isPinned = State(initialValue: todo.isPinned)
        _isAchieved = State(initialValue: todo.isAchieved)
        _achievedAt = State(initialValue: todo.achievedAt ?? Date())
        self.oldIsPinned = todo.isPinned
        self.oldIsAchieved = todo.isAchieved
    }
    
    var body: some View {
        NavigationView {
            
            Form {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $content)
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
                    }
                }
                
                Button(action: {
                    isConfirming.toggle()
                }){
                    Text("deleteTodo")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            
            .confirmationDialog("areYouSureYouWantToDeleteThisTodo", isPresented: $isConfirming, titleVisibility: .visible) {
                Button("deleteTodo", role: .destructive) {
                    FirestoreTodo.delete(id: id)
                    dismiss()
                }
            }
            
            .navigationTitle("editTodo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        // contentとachievedAtを更新
                        FirestoreTodo.update(id: id, content: content, achievedAt: achievedAt)
                        // isPinnedに変化があれば更新
                        if !oldIsPinned && isPinned {
                            FirestoreTodo.pin(id: id)
                        }
                        if oldIsPinned && !isPinned {
                            FirestoreTodo.unpin(id: id)
                        }
                        // isAchievedに変化があれば更新
                        if !oldIsAchieved && isAchieved {
                            FirestoreTodo.achieve(id: id)
                        }
                        if oldIsAchieved && !isAchieved {
                            FirestoreTodo.unachieve(id: id)
                        }
                        dismiss()
                    }){
                        Text("done")
                            .fontWeight(.bold)
                    }
                    .disabled(content.isEmpty)
                }
            }
        }
    }
}
