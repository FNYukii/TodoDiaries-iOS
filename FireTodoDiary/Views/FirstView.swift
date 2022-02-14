//
//  FirstView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct FirstView: View {
    
    @ObservedObject private var pinnedTodosViewModel = TodosViewModel(isPinned: true, isAchieved: false, isWithAnimation: true)
    @ObservedObject private var unpinnedTodosViewModel = TodosViewModel(isPinned: false, isAchieved: false, isWithAnimation: true)
    
    @State private var isShowCreateSheet = false
    @State private var isShowEditSheet = false
    
    @State private var isConfirming = false
    @State private var todoUnderConfirm: Todo? = nil
    
    var body: some View {
        NavigationView {
            
            List {
                // Pinned Todos Section
                if pinnedTodosViewModel.todos.count != 0 {
                    Section(header: Text("pinned")) {
                        ForEach(pinnedTodosViewModel.todos){todo in
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
                }
                // Not Pinned Todos Section
                if unpinnedTodosViewModel.todos.count != 0{
                    Section(header: pinnedTodosViewModel.todos.count == 0 ? nil : Text("others")) {
                        ForEach(unpinnedTodosViewModel.todos){todo in
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
                }
            }
            
            .sheet(isPresented: $isShowCreateSheet) {
                CreateTodoView()
            }
            
            .confirmationDialog("areYouSureYouWantToDeleteThisTodo", isPresented: $isConfirming, titleVisibility: .visible) {
                Button("deleteTodo", role: .destructive) {
                    TodoDocument.delete(id: todoUnderConfirm!.id)
                }
            } message: {
                Text(todoUnderConfirm != nil ? todoUnderConfirm!.content : "")
            }
            
            .navigationBarTitle("todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowCreateSheet.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                        Text("newTodo")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomEditButton()
                }
            }
        }
    }
}
