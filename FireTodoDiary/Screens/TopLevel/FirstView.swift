//
//  FirstView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct FirstView: View {
    
    @ObservedObject private var pinnedTodosViewModel = UnachievedTodosViewModel(isPinned: true)
    @ObservedObject private var unpinnedTodosViewModel = UnachievedTodosViewModel(isPinned: false)
    
    @State private var isShowCreateSheet = false
    
    var body: some View {
        NavigationView {
            
            ZStack {
                List {
                    if pinnedTodosViewModel.todos.count != 0 {
                        TodoSection(todos: pinnedTodosViewModel.todos, header: Text("pinned"))
                    }
                    if unpinnedTodosViewModel.todos.count != 0{
                        TodoSection(todos: unpinnedTodosViewModel.todos, header: pinnedTodosViewModel.todos.count != 0 ? Text("others") : nil)
                    }
                }
                
                if pinnedTodosViewModel.todos.count == 0 && unpinnedTodosViewModel.todos.count == 0 && pinnedTodosViewModel.isLoaded && unpinnedTodosViewModel.isLoaded {
                    VStack {
                        Text("まだTodoはありません")
                        Text("Todoを追加するとここに表示されます")
                    }
                    .foregroundColor(.secondary)
                }
            }
            
            .sheet(isPresented: $isShowCreateSheet) {
                CreateTodoView()
            }
            
            .navigationTitle("todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowCreateSheet.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                        Text("newTodo")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    ShowAccountViewButton()
                    CustomEditButton()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
