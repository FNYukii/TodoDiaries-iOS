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
    @State private var content = ""
    @State private var isPinned = false
    @State private var isAchieved = false
    @State private var achievedAt: Date = Date()
    
    @State private var isConfirming = false
    
    init(todo: Todo) {
        self.id = todo.id
        _content = State(initialValue: todo.content)
        _isPinned = State(initialValue: todo.isPinned)
        _isAchieved = State(initialValue: todo.isAchieved)
        _achievedAt = State(initialValue: todo.achievedAt ?? Date())
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
                            .environment(\.locale, Locale(identifier: "ja_JP"))
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
                    TodoViewModel.delete(id: id)
                    dismiss()
                }
            }
            
            .navigationBarTitle("editTodo", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        TodoViewModel.update(id: id, content: content, isPinned: isPinned, isAchieved: isAchieved, achievedAt: achievedAt)
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
