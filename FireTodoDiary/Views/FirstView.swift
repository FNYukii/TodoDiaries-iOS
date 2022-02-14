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
                                ContextMenuGroup(todoId: todo.id, isPinned: true)
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
                                ContextMenuGroup(todoId: todo.id)
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
            
            .navigationBarTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowCreateSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomEditButton()
                }
            }
        }
    }
}
