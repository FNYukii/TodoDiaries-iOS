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
    private let oldAchievedAt: Date?
    
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
        self.oldAchievedAt = todo.achievedAt
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
                
                Button(action: {
                    isConfirming.toggle()
                }){
                    Text("deleteTodo")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .confirmationDialog("areYouSureYouWantToDeleteThisTodo", isPresented: $isConfirming, titleVisibility: .visible) {
                    Button("deleteTodo", role: .destructive) {
                        FireTodo.deleteTodo(id: id, achievedAt: oldAchievedAt)
                        dismiss()
                    }
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
                        // contentを更新
                        FireTodo.updateTodo(id: id, content: content)
                        
                        // isAchievedに変化があれば更新
                        if !oldIsAchieved && isAchieved {
                            FireTodo.achieveTodo(id: id, achievedAt: achievedAt)
                        }
                        if oldIsAchieved && !isAchieved {
                            FireTodo.unachieveTodo(id: id)
                        }
                        
                        // isPinnedに変化があれば更新
                        if oldIsPinned != true && isPinned == true {
                            FireTodo.pinTodo(id: id)
                        }
                        if oldIsPinned == true && isPinned != true {
                            FireTodo.unpinTodo(id: id)
                        }
                        
                        // 達成済みのままで、achievedAtに変化があれば対応
                        if oldIsAchieved && isAchieved && oldAchievedAt != achievedAt {
                            FireTodo.updateTodo(id: id, achievedAt: achievedAt)
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
