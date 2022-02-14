//
//  TodosOfTheDaySection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/14.
//

import SwiftUI

struct AchievedTodoSection: View {
        
    let headerText: String
    
    @ObservedObject var todoViewModel: TodoViewModel
    @State var isShowEditSheet = false
    
    init(achievedDay: Int) {
        self.headerText = Day.toYmdwString(from: achievedDay)
        self.todoViewModel = TodoViewModel(achievedDay: achievedDay)
    }
    
    var body: some View {
        Section(header: Text(headerText)) {
            ForEach(todoViewModel.todos){todo in
                Button(action: {
                    isShowEditSheet.toggle()
                }) {
                    HStack {
                        Text(Day.toHmString(from: todo.achievedAt!))
                            .foregroundColor(.secondary)
                        Text(todo.content)
                            .foregroundColor(.primary)
                    }
                }
                .sheet(isPresented: $isShowEditSheet) {
                    EditTodoView(todo: todo)
                }
            }
        }
    }
}
