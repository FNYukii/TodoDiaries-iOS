//
//  ContextMenuGroup.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/14.
//

import SwiftUI

struct TodoContextMenuItems: View {
    
    let todo: Todo
    @Binding var isConfirming: Bool
    @Binding var todoUnderConfirming: Todo?
    
    var body: some View {
        Group {
            
            if !todo.isPinned && !todo.isAchieved {
                Button(action: {
                    FirestoreTodo.pin(id: todo.id)
                }) {
                    Label("pin", systemImage: "pin")
                }
            }
            
            if todo.isPinned && !todo.isAchieved {
                Button(action: {
                    FirestoreTodo.unpin(id: todo.id)
                }) {
                    Label("unpin", systemImage: "pin.slash")
                }
            }
            
            if !todo.isAchieved {
                Button(action: {
                    FirestoreTodo.update(id: todo.id, isAchieved: true)
                }) {
                    Label("makeAchieved", systemImage: "checkmark")
                }
            }
            
            if todo.isAchieved {
                Button(action: {
                    FirestoreTodo.update(id: todo.id, isAchieved: false)
                }) {
                    Label("makeUnachieved", systemImage: "xmark")
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
