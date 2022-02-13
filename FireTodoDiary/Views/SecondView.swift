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
            
            .onChange(of: achievedTodoViewModel.todos){ value in
                // 達成済みの全てのTodo
                let achievedTodos = achievedTodoViewModel.todos
                
                // Todo達成日の配列 [20220213, 20220214, ...]
                var achievedDays: [Int] = []
                for achievedTodo in achievedTodos {
                    let achievedDay = achievedTodo.achievedDay!
                    achievedDays.append(achievedDay)
                }
                
                // 配列から重複した要素を削除
                let orderdSet = NSOrderedSet(array: achievedDays)
                achievedDays = orderdSet.array as! [Int]
                
                print("HELLO! achievedDays: \(achievedDays)")
            }
            
            .navigationTitle("達成済み")
        }
    }
}
