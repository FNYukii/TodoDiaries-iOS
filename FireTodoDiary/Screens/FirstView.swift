//
//  FirstView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI
import FirebaseAuth

struct FirstView: View {
    
    @ObservedObject private var pinnedTodosViewModel = TodosViewModel(isPinned: true, isAchieved: false)
    @ObservedObject private var unpinnedTodosViewModel = TodosViewModel(isPinned: false, isAchieved: false)
    
    @State private var isShowCreateSheet = false
    
    var body: some View {
        NavigationView {
            
            List {
                if pinnedTodosViewModel.todos.count != 0 {
                    TodoSection(todos: pinnedTodosViewModel.todos, header: Text("pinned"))
                }
                if unpinnedTodosViewModel.todos.count != 0{
                    TodoSection(todos: unpinnedTodosViewModel.todos, header: pinnedTodosViewModel.todos.count != 0 ? Text("others") : nil)
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
//                    CustomEditButton()
                    Button("Sign out") {
                        do {
                            try Auth.auth().signOut()
                        } catch {
                            print("Error")
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
