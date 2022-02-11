//
//  EditTodoView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct EditTodoView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var content = ""
    @State var isPinned = false
    @State var isAchieved = false
    @State var achievedAt: Date = Date()
    
    init(todo: Todo) {
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
                    //TODO: Delete document
                }){
                    Text("Todoを削除")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
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
                        TodoViewModel.create(content: content, isPinned: isPinned, isAchieved: isAchieved, achievedAt: achievedAt)
                        dismiss()
                    }){
                        Text("追加")
                            .fontWeight(.bold)
                    }
                    .disabled(content.isEmpty)
                }
            }
        }
    }
}
