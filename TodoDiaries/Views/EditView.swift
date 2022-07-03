//
//  EditTodoView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let id: String
    @State private var content: String
    @State private var isPinned: Bool
    @State private var isAchieved: Bool
    @State private var achievedAt: Date
    private let oldIsPinned: Bool?
    private let oldIsAchieved: Bool
    
    @State private var isConfirming = false
    @State private var isSended = false
    
    init(todo: Todo) {
        self.id = todo.id
        _content = State(initialValue: todo.content)
        _isPinned = State(initialValue: todo.achievedAt == nil ? todo.isPinned! : false)
        _isAchieved = State(initialValue: todo.achievedAt != nil)
        _achievedAt = State(initialValue: todo.achievedAt ?? Date())
        self.oldIsPinned = todo.isPinned
        self.oldIsAchieved = todo.achievedAt != nil
    }
    
    var body: some View {
        NavigationView {
            
            Form {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $content)
                        .frame(minHeight: 80)
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
                
                Button(action: {
                    isConfirming.toggle()
                }){
                    Text("delete_todo")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .confirmationDialog("are_you_sure_you_want_to_delete_this_todo", isPresented: $isConfirming, titleVisibility: .visible) {
                    Button("delete_todo", role: .destructive) {
                        FireTodo.deleteTodo(id: id)
                        dismiss()
                    }
                }
            }
            
            .navigationTitle("edit_todo")
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
                        FireTodo.updateTodo(id: id, content: content, achievedAt: isAchieved ? achievedAt : nil)
                        
                        // isPinnedに変化があれば更新
                        if oldIsPinned != true && isPinned == true && oldIsAchieved == false {
                            FireTodo.pinTodo(id: id)
                        }
                        if oldIsPinned == true && isPinned != true && oldIsAchieved == false {
                            FireTodo.unpinTodo(id: id)
                        }
                        
                        // 達成済みへ
                        if !oldIsAchieved && isAchieved {
                            FireTodo.achieveTodo(id: id, achievedAt: achievedAt)
                        }
                        
                        // 未達成へ戻す
                        if oldIsAchieved && !isAchieved {
                            FireTodo.unachieveTodo(id: id, isMakePinned: isPinned)
                        }
                        
                        isSended = true
                        dismiss()
                    }){
                        Text("done")
                            .fontWeight(.bold)
                    }
                    .disabled(content.isEmpty || isSended)
                }
            }
        }
    }
}
