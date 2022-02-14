//
//  ContextMenuGroup.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/14.
//

import SwiftUI

struct TodoContextMenuItems: View {
    
    private let todo: Todo
    
    @Binding private var isConfirming: Bool
    @Binding private var todoUnderConfirming: Todo?
    
    init(todo: Todo, isConfirming: Binding<Bool>, todoUnderConfirming: Binding<Todo?>) {
        self.todo = todo
        self._isConfirming = isConfirming
        self._todoUnderConfirming = todoUnderConfirming
    }
    
    var body: some View {
        Group {
            
            if !todo.isPinned && !todo.isAchieved {
                Button(action: {
                    TodoViewModel.update(id: todo.id, isPinned: true)
                }) {
                    Label("固定する", systemImage: "pin")
                }
            }
            
            if todo.isPinned && !todo.isAchieved {
                Button(action: {
                    TodoViewModel.update(id: todo.id, isPinned: false)
                }) {
                    Label("固定を解除", systemImage: "pin.slash")
                }
            }
            
            if !todo.isAchieved {
                Button(action: {
                    TodoViewModel.update(id: todo.id, isAchieved: true)
                }) {
                    Label("達成済みにする", systemImage: "checkmark")
                }
            }
            
            if todo.isAchieved {
                Button(action: {
                    TodoViewModel.update(id: todo.id, isAchieved: false)
                }) {
                    Label("未達成に戻す", systemImage: "xmark")
                }
            }
            
            Button(role: .destructive) {
                todoUnderConfirming = todo
                isConfirming.toggle()
            } label: {
                Label("削除", systemImage: "trash")
            }
        }
    }
}
