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
        
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            // Achieve
            if !todo.isAchieved {
                Button(action: {
                    FireTodo.achieveTodo(id: todo.id)
                }) {
                    Image(systemName: "checkmark")
                }
                .tint(.accentColor)
            }
            // Unachieve
            if todo.isAchieved {
                Button(action: {
                    FireTodo.unachieveTodo(id: todo.id, achievedAt: todo.achievedAt!)
                }) {
                    Image(systemName: "xmark")
                }
                .tint(.accentColor)
            }
            // Pin
            if !todo.isPinned && !todo.isAchieved {
                Button(action: {
                    FireTodo.pinTodo(id: todo.id)
                }) {
                    Image(systemName: "pin")
                }
                .tint(.orange)
            }
            // Unpin
            if todo.isPinned && !todo.isAchieved {
                Button(action: {
                    FireTodo.unpinTodo(id: todo.id)
                }) {
                    Image(systemName: "pin.slash")
                }
                .tint(.orange)
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(action: {
                isConfirming.toggle()
            }) {
                Image(systemName: "trash")
            }
            .tint(.red)
        }
        
        .confirmationDialog("areYouSureYouWantToDeleteThisTodo", isPresented: $isConfirming, titleVisibility: .visible) {
            Button("deleteTodo", role: .destructive) {
                FireTodo.deleteTodo(id: todo.id)
            }
        } message: {
            Text(todo.content)
        }
    }
}
