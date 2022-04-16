//
//  TodoRow.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/04/16.
//

import SwiftUI

struct TodoRow: View {
    
    let todo: Todo
    
    @State private var isShowEditSheet = false
    @State private var isConfirming = false
    
    var body: some View {
        Button(action: {
            isShowEditSheet.toggle()
        }) {
            HStack {
                if todo.isAchieved {
                    Text(DayConverter.toTimeString(from: todo.achievedAt!))
                        .foregroundColor(.secondary)
                }
                Text(todo.content)
                    .foregroundColor(.primary)
            }
        }
        
        .foregroundColor(.primary)
        .sheet(isPresented: $isShowEditSheet) {
            EditView(todo: todo)
        }
        
        .contextMenu {
            TodoContextMenuItems(todo: todo, isConfirming: $isConfirming)
        }
        
        .swipeActions(edge: .leading, allowsFullSwipe: false) {
            // Pin
            if !todo.isPinned && !todo.isAchieved {
                Button(action: {
                    FireTodo.pin(id: todo.id)
                }) {
                    Image(systemName: "pin")
                }
                .tint(.accentColor)
            }
            // Unpin
            if todo.isPinned && !todo.isAchieved {
                Button(action: {
                    FireTodo.unpin(id: todo.id)
                }) {
                    Image(systemName: "pin.slash")
                }
                .tint(.accentColor)
            }
            // Achieve
            if !todo.isAchieved {
                Button(action: {
                    FireTodo.achieve(id: todo.id)
                }) {
                    Image(systemName: "checkmark")
                }
                .tint(.orange)
            }
            // Unachieve
            if todo.isAchieved {
                Button(action: {
                    FireTodo.unachieve(id: todo.id, achievedAt: todo.achievedAt!)
                }) {
                    Image(systemName: "xmark")
                }
                .tint(.orange)
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button(action: {
                isConfirming.toggle()
            }) {
                Image(systemName: "trash")
            }
            .tint(.red)
        }
        
        .confirmationDialog("areYouSureYouWantToDeleteThisTodo", isPresented: $isConfirming, titleVisibility: .visible) {
            Button("deleteTodo", role: .destructive) {
                FireTodo.delete(id: todo.id)
            }
        } message: {
            Text(todo.content)
        }
    }
}
