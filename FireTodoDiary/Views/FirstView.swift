//
//  FirstView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct FirstView: View {
    
    @ObservedObject var todoViewModel = TodoViewModel()
    
    @State var isShowCreateSheet = false
    @State var isShowEditSheet = false
    
    init() {
        todoViewModel.readUnpinnedTodos()
        todoViewModel.readPinnedTodos()
    }
    
    var body: some View {
        NavigationView {
            
            List {
                // Pinned Todos Section
                if todoViewModel.pinnedTodos.count != 0 {
                    Section(header: Text("固定済み")) {
                        ForEach(todoViewModel.pinnedTodos){todo in
                            Button(todo.content) {
                                isShowEditSheet.toggle()
                            }
                            .foregroundColor(.primary)
                            .sheet(isPresented: $isShowEditSheet) {
                                EditTodoView(todo: todo)
                            }
                        }
                    }
                }
                // Not Pinned Todos Section
                if todoViewModel.unpinnedTodos.count != 0{
                    Section(header: todoViewModel.pinnedTodos.count == 0 ? nil : Text("その他")) {
                        ForEach(todoViewModel.unpinnedTodos){todo in
                            Button(todo.content) {
                                isShowEditSheet.toggle()
                            }
                            .foregroundColor(.primary)
                            .sheet(isPresented: $isShowEditSheet) {
                                EditTodoView(todo: todo)
                            }
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
