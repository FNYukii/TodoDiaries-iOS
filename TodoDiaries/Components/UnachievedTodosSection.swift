//
//  UnachievedTodoSection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import SwiftUI

struct UnachievedTodosSection: View {
    
    let todos: [Todo]
    let header: Text?
    
    var body: some View {
        
        Section(header: header) {
            ForEach(todos){todo in
                TodoRow(todo: todo)
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
                    FireTodo.updateTodo(id: movedTodo.id, order: newOrder)
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
                    FireTodo.updateTodo(id: movedTodo.id, order: newOrder)
                }
            }
        }
    }
}
