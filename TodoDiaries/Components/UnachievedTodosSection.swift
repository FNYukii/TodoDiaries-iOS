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
                FireTodo.moveTodos(todos: todos, sourceIndexSet: sourceIndexSet, destination: destination)
            }
        }
    }
}
