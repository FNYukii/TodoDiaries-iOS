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
                        UnachievedTodosSection(todos: pinnedTodosViewModel.todos, header: Text("pinned"))
                    }
                    if unpinnedTodosViewModel.todos.count != 0{
                        UnachievedTodosSection(todos: unpinnedTodosViewModel.todos, header: pinnedTodosViewModel.todos.count != 0 ? Text("others") : nil)
                    }
                }
                
                if pinnedTodosViewModel.todos.count == 0 && unpinnedTodosViewModel.todos.count == 0 {
                    if !pinnedTodosViewModel.isLoaded || !unpinnedTodosViewModel.isLoaded {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                }
                
                if pinnedTodosViewModel.todos.count == 0 && unpinnedTodosViewModel.todos.count == 0 && pinnedTodosViewModel.isLoaded && unpinnedTodosViewModel.isLoaded {
                    VStack {
                        Text("there_is_no_todo_yet")
                        Text("when_you_create_a_todo_it_will_appear_here")
                    }
                    .foregroundColor(.secondary)
                }
            }
            
            .sheet(isPresented: $isShowCreateSheet) {
                CreateView()
            }
            
            .navigationTitle("todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowCreateSheet.toggle()
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("new_todo")
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
