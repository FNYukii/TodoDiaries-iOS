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
    private let oldAchievedAt: Date?
    
    @State private var isConfirming = false
    @State private var isSended = false
    
    init(todo: Todo) {
        self.id = todo.id
        _content = State(initialValue: todo.content)
        _isPinned = State(initialValue: todo.isPinned)
        _isAchieved = State(initialValue: todo.isAchieved)
        _achievedAt = State(initialValue: todo.achievedAt ?? Date())
        self.oldIsPinned = todo.isPinned
        self.oldIsAchieved = todo.isAchieved
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
                        FireTodo.delete(id: id, achievedAt: oldAchievedAt)
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
                        FireTodo.update(id: id, content: content)
                        // isPinnedに変化があれば更新
                        if !oldIsPinned && isPinned {
                            FireTodo.pin(id: id)
                        }
                        if oldIsPinned && !isPinned {
                            FireTodo.unpin(id: id)
                        }
                        // isAchievedに変化があれば更新
                        if !oldIsAchieved && isAchieved {
                            FireTodo.achieve(id: id, achievedAt: achievedAt)
                        }
                        if oldIsAchieved && !isAchieved {
                            FireTodo.unachieve(id: id, achievedAt: oldAchievedAt!)
                        }
                        // 達成済みのままで、achievedAtに変化があれば対応
                        if oldIsAchieved && isAchieved && oldAchievedAt != achievedAt {
                            FireTodo.update(id: id, achievedAt: achievedAt)
                            FireCounter.decrement(achievedAt: oldAchievedAt!)
                            FireCounter.increment(achievedAt: achievedAt)
                        }
                        isSended = true
                        dismiss()
                    }){
                        Text("done")
                            .fontWeight(.bold)
                    }
                    .disabled(content.isEmpty && !isSended)
                }
            }
        }
    }
}
