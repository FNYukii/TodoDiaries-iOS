//
//  TodosOfTheDaySection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/14.
//

import SwiftUI

struct AchievedTodoSection: View {
        
    let achievedDay: Int
    
    @ObservedObject var todoViewModel: TodoViewModel
    @State var isShowEditSheet = false
    
    init(achievedDay: Int) {
        self.achievedDay = achievedDay
        self.todoViewModel = TodoViewModel(achievedDay: achievedDay)
    }
    
    var body: some View {
        Section(header: Text("\(achievedDay)")) {
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
    }
}
