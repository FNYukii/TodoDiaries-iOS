//
//  FirstView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct FirstView: View {
    
    @ObservedObject private var pinnedTodoViewModel = TodoViewModel(isPinned: true, isAchieved: false, isWithAnimation: true)
    @ObservedObject private var unpinnedTodoViewModel = TodoViewModel(isPinned: false, isAchieved: false, isWithAnimation: true)
    
    @State private var isShowCreateSheet = false
    @State private var isShowEditSheet = false
    
    @State private var isConfirming = false
    @State private var todoUnderConfirm: Todo? = nil
    
    var body: some View {
        NavigationView {
            
            List {
                // Pinned Todos Section
                if pinnedTodoViewModel.todos.count != 0 {
                    Section(header: Text("固定済み")) {
                        ForEach(pinnedTodoViewModel.todos){todo in
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
                if unpinnedTodoViewModel.todos.count != 0{
                    Section(header: pinnedTodoViewModel.todos.count == 0 ? nil : Text("その他")) {
                        ForEach(unpinnedTodoViewModel.todos){todo in
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
            
            .confirmationDialog("このTodoを削除してもよろしいですか?", isPresented: $isConfirming, titleVisibility: .visible) {
                Button("Todoを削除", role: .destructive) {
                    TodoViewModel.delete(id: todoUnderConfirm!.id)
                }
            } message: {
                Text(todoUnderConfirm != nil ? todoUnderConfirm!.content : "")
            }
            
            .navigationBarTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowCreateSheet.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                        Text("新規Todo")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomEditButton()
                }
            }
        }
    }
}
