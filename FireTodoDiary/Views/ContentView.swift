//
//  ContentView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var todoViewModel = TodoViewModel()
    
    @State var isShowCreateSheet = false
    @State var isShowEditSheet = false
    
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(todoViewModel.todos){todo in
                    Button(todo.content) {
                        isShowEditSheet.toggle()
                    }
                    .foregroundColor(.primary)
                    .sheet(isPresented: $isShowEditSheet) {
                        EditTodoView(todo: todo)
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
            }
        }
    }
}
