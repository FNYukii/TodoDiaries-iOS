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
                    Label("pin", systemImage: "pin")
                }
            }
            
            if todo.isPinned && !todo.isAchieved {
                Button(action: {
                    TodoViewModel.update(id: todo.id, isPinned: false)
                }) {
                    Label("unpin", systemImage: "pin.slash")
                }
            }
            
            if !todo.isAchieved {
                Button(action: {
                    TodoViewModel.update(id: todo.id, isAchieved: true)
                }) {
                    Label("achieve", systemImage: "checkmark")
                }
            }
            
            if todo.isAchieved {
                Button(action: {
                    TodoViewModel.update(id: todo.id, isAchieved: false)
                }) {
                    Label("unachieve", systemImage: "xmark")
                }
            }
            
            Button(role: .destructive) {
                todoUnderConfirming = todo
                isConfirming.toggle()
            } label: {
                Label("delete", systemImage: "trash")
            }
        }
    }
}
