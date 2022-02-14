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
                
                Button(action: {
                    isConfirming.toggle()
                }){
                    Text("Todoを削除")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            
            .confirmationDialog("このTodoを削除してもよろしいですか?", isPresented: $isConfirming, titleVisibility: .visible) {
                Button("Todoを削除", role: .destructive) {
                    TodoViewModel.delete(id: id)
                    dismiss()
                }
            }
            
            .navigationBarTitle("Todoを編集", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        TodoViewModel.update(id: id, content: content, isPinned: isPinned, isAchieved: isAchieved, achievedAt: achievedAt)
                        dismiss()
                    }){
                        Text("完了")
                            .fontWeight(.bold)
                    }
                    .disabled(content.isEmpty)
                }
            }
        }
    }
}
