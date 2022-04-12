//
//  TodosOfTheDaySection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/14.
//

import SwiftUI

struct DailyAchievedTodosSection: View {
    
    private let title: String
    
    @ObservedObject private var todosViewModel: DailyAchievedTodosViewModel
    
    @State private var isShowEditSheet = false
    @State private var isConfirming = false
    @State private var todoUnderConfirm: Todo? = nil
    
    init(achievedDay: DateComponents) {
        self.title = Day.toStringUpToWeekday(from: achievedDay)
        self.todosViewModel = DailyAchievedTodosViewModel(achievedDay: achievedDay)
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
                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                    Button(action: {
                        FireTodo.unachieve(id: todo.id, achievedAt: todo.achievedAt!)
                    }) {
                        Image(systemName: "xmark")
                    }
                    .tint(.orange)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(action: {
                        todoUnderConfirm = todo
                        isConfirming.toggle()
                    }) {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                }
            }
        }
        
        .confirmationDialog("areYouSureYouWantToDeleteThisTodo", isPresented: $isConfirming, titleVisibility: .visible) {
            Button("deleteTodo", role: .destructive) {
                FireTodo.delete(id: todoUnderConfirm!.id, achievedAt: todoUnderConfirm!.achievedAt)
            }
        } message: {
            Text(todoUnderConfirm != nil ? todoUnderConfirm!.content : "")
        }
        
    }
}
