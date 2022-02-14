//
//  UnachievedTodoSection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import SwiftUI

struct TodoSection: View {
    
    let todos: [Todo]
    let title: String?
    
    @State private var isShowEditSheet = false
    @State private var isConfirming = false
    @State private var todoUnderConfirm: Todo? = nil
    
    var body: some View {
        
        Section(header: title != nil ? Text(title!) : nil) {
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
                //TODO: Update order
            }
        }
            
        .confirmationDialog("areYouSureYouWantToDeleteThisTodo", isPresented: $isConfirming, titleVisibility: .visible) {
            Button("deleteTodo", role: .destructive) {
                TodoDocument.delete(id: todoUnderConfirm!.id)
            }
        } message: {
            Text(todoUnderConfirm != nil ? todoUnderConfirm!.content : "")
        }
    }
}
