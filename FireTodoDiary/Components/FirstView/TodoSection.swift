//
//  UnachievedTodoSection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import SwiftUI

struct TodoSection: View {
    
    let todos: [Todo]
    let header: Text?
    
    @State private var isShowEditSheet = false
    @State private var isConfirming = false
    @State private var todoUnderConfirm: Todo? = nil
    
    var body: some View {
        
        Section(header: header) {
            ForEach(todos){todo in
                Button(todo.content) {
                    isShowEditSheet.toggle()
                }
                .foregroundColor(.primary)
                .sheet(isPresented: $isShowEditSheet) {
                    EditTodoView(todo: todo)
                }
                .contextMenu {
                    TodoContextMenuItems(todo: todo, isConfirming: $isConfirming, todoUnderConfirming: $todoUnderConfirm)
                }
            }
            .onMove {sourceIndexSet, destination in
                // 移動元と移動先のindexを取得
                let from = Int(sourceIndexSet.first!)
                var destination = destination
                if from < destination {
                    destination -= 1
                }
                
                if from > destination {
                    // Todoを上に移動
                    let movedTodo = todos[from]
                    var newOrder = 0.0
                    if destination == 0 {
                        let minOrder = todos.first!.order
                        newOrder = minOrder - 100
                    } else {
                        let prevOrder = todos[destination - 1].order
                        let nextOrder = todos[destination].order
                        newOrder = (prevOrder + nextOrder) / 2
                    }
                    FireTodo.update(id: movedTodo.id, order: newOrder)
                }
                
                if from < destination {
                    // Todoを下に移動
                    let movedTodo = todos[from]
                    var newOrder = 0.0
                    if destination == todos.count - 1 {
                        let maxOrder = todos.last!.order
                        newOrder = maxOrder + 100
                    } else {
                        let prevOrder = todos[destination].order
                        let nextOrder = todos[destination + 1].order
                        newOrder = (prevOrder + nextOrder) / 2
                    }
                    FireTodo.update(id: movedTodo.id, order: newOrder)
                }
            }
            
            .onDelete {indexSet in
                todoUnderConfirm = todos[indexSet.first!]
                isConfirming.toggle()
            }
        }
        
        .confirmationDialog("areYouSureYouWantToDeleteThisTodo", isPresented: $isConfirming, titleVisibility: .visible) {
            Button("deleteTodo", role: .destructive) {
                FireTodo.delete(id: todoUnderConfirm!.id)
            }
        } message: {
            if todoUnderConfirm != nil {
                Text(todoUnderConfirm!.content)
            }
        }
    }
}
