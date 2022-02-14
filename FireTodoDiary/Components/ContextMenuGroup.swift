//
//  ContextMenuGroup.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/14.
//

import SwiftUI

struct ContextMenuGroup: View {
    
    let todoId: String
    let todoIsPinned: Bool
    let todoIsAchieved: Bool
    
    init(todoId: String, isPinned: Bool = false, isAchieved: Bool = false) {
        self.todoId = todoId
        self.todoIsPinned = isPinned
        self.todoIsAchieved = isAchieved
    }
    
    var body: some View {
        Group {
            
            if !todoIsPinned && !todoIsAchieved {
                Button(action: {
                    TodoViewModel.update(id: todoId, isPinned: true)
                }) {
                    Label("固定する", systemImage: "pin")
                }
            }
            
            if todoIsPinned && !todoIsAchieved {
                Button(action: {
                    TodoViewModel.update(id: todoId, isPinned: false)
                }) {
                    Label("固定を解除", systemImage: "pin.slash")
                }
            }
            
            if !todoIsAchieved {
                Button(action: {
                    TodoViewModel.update(id: todoId, isAchieved: true)
                }) {
                    Label("達成済みにする", systemImage: "checkmark")
                }
            }
            
            if todoIsAchieved {
                Button(action: {
                    TodoViewModel.update(id: todoId, isAchieved: false)
                }) {
                    Label("未達成に戻す", systemImage: "xmark")
                }
            }
            
            Button(role: .destructive) {
                TodoViewModel.delete(id: todoId)
            } label: {
                Label("削除", systemImage: "trash")
            }
        }
    }
}
