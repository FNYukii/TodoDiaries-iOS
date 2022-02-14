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
    
    var body: some View {
        NavigationView {
            
            List {
                // Pinned Todos Section
                if pinnedTodosViewModel.todos.count != 0 {
                    TodoSection(todos: pinnedTodosViewModel.todos, title: "pinned")
                }
                // Not Pinned Todos Section
                if unpinnedTodosViewModel.todos.count != 0{
                    TodoSection(todos: unpinnedTodosViewModel.todos, title: pinnedTodosViewModel.todos.count == 0 ? nil : "others")
                }
            }
            
            .sheet(isPresented: $isShowCreateSheet) {
                CreateTodoView()
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
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
