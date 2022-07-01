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
        
        // Todo
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
        
        // Sheet
        .sheet(isPresented: $isShowEditSheet) {
            EditView(todo: todo)
        }
        
        // Context Menu
        .contextMenu {
            if !todo.isPinned && !todo.isAchieved {
                Button(action: {
                    FireTodo.pinTodo(id: todo.id)
                }) {
                    Label("pin", systemImage: "pin")
                }
            }
            
            if todo.isPinned && !todo.isAchieved {
                Button(action: {
                    FireTodo.unpinTodo(id: todo.id)
                }) {
                    Label("unpin", systemImage: "pin.slash")
                }
            }
            
            if !todo.isAchieved {
                Button(action: {
                    FireTodo.achieveTodo(id: todo.id, achievedAt: Date())
                }) {
                    Label("makeAchieved", systemImage: "checkmark")
                }
            }
            
            if todo.isAchieved {
                Button(action: {
                    FireTodo.unachieveTodo(id: todo.id)
                }) {
                    Label("makeUnachieved", systemImage: "xmark")
                }
            }
            
            Button(role: .destructive) {
                isConfirming.toggle()
            } label: {
                Label("delete", systemImage: "trash")
            }
        }
        
        // Swipe Actions
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            // Achieve
            if !todo.isAchieved {
                Button(action: {
                    FireTodo.achieveTodo(id: todo.id, achievedAt: Date())
                }) {
                    Image(systemName: "checkmark")
                }
                .tint(.accentColor)
            }
            // Unachieve
            if todo.isAchieved {
                Button(action: {
                    FireTodo.unachieveTodo(id: todo.id)
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
        
        // Swipe Actions
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(action: {
                isConfirming.toggle()
            }) {
                Image(systemName: "trash")
            }
            .tint(.red)
        }
        
        // Dialog
        .confirmationDialog("areYouSureYouWantToDeleteThisTodo", isPresented: $isConfirming, titleVisibility: .visible) {
            Button("deleteTodo", role: .destructive) {
                FireTodo.deleteTodo(id: todo.id)
            }
        } message: {
            Text(todo.content)
        }
    }
}
