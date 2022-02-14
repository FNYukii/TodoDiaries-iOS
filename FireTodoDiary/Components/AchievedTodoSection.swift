//
//  TodosOfTheDaySection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/14.
//

import SwiftUI

struct AchievedTodoSection: View {
        
    private let headerText: String
    
    @ObservedObject private var todoViewModel: TodoViewModel
    @State private var isShowEditSheet = false
    
    @State private var isConfirming = false
    @State private var todoUnderConfirm: Todo? = nil
    
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
                .contextMenu {
                    TodoContextMenuItems(todo: todo, isConfirming: $isConfirming, todoUnderConfirming: $todoUnderConfirm)
                }
            }
        }
        
        .confirmationDialog("このTodoを削除してもよろしいですか?", isPresented: $isConfirming, titleVisibility: .visible) {
            Button("Todoを削除", role: .destructive) {
                TodoViewModel.delete(id: todoUnderConfirm!.id)
            }
        } message: {
            Text(todoUnderConfirm != nil ? todoUnderConfirm!.content : "")
        }
        
    }
}
