//
//  SecondView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct SecondView: View {
    
    @ObservedObject var achievedTodoViewModel = TodoViewModel(isAchieved: true)
    
    @State var isShowEditSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(achievedTodoViewModel.todos) {todo in
                    Button(todo.content) {
                        isShowEditSheet.toggle()
                    }
                    .foregroundColor(.primary)
                    .sheet(isPresented: $isShowEditSheet) {
                        EditTodoView(todo: todo)
                    }
                }
            }
            
            .navigationTitle("達成済み")
        }
    }
}
