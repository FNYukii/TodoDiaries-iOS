//
//  TodosOfTheDaySection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/14.
//

import SwiftUI

struct AchievementSection: View {
        
    private let title: String
    
    @ObservedObject private var todosViewModel: TodosViewModel
    
    @State private var isShowEditSheet = false
    @State private var isConfirming = false
    @State private var todoUnderConfirm: Todo? = nil
    
    init(achievedDay: Int) {
        self.title = Day.toDateString(from: achievedDay)
        self.todosViewModel = TodosViewModel(achievedDay: achievedDay)
    }
    
    var body: some View {
        Section(header: Text(title)) {
            ForEach(todosViewModel.todos){todo in
                Button(action: {
                    isShowEditSheet.toggle()
                }) {
                    HStack {
                        Text(Day.toTimeString(from: todo.achievedAt!))
                            .foregroundColor(.secondary)
                        Text(todo.content)
                            .foregroundColor(.primary)
                    }
                }
                .sheet(isPresented: $isShowEditSheet) {
                    EditTodoView(todo: todo)
                }
                .contextMenu {
                    TodoContextMenuItems(todo: todo, isConfirming: $isConfirming, todoUnderConfirming: $todoUnderConfirm)
                }
            }
        }
        
        .confirmationDialog("areYouSureYouWantToDeleteThisTodo", isPresented: $isConfirming, titleVisibility: .visible) {
            Button("deleteTodo", role: .destructive) {
                TodoDocument.delete(id: todoUnderConfirm!.id)
            }
        } message: {
            Text(todoUnderConfirm != nil ? todoUnderConfirm!.content : "")
        }
        
    }
}
