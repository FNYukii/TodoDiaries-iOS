//
//  SecondView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct SecondView: View {
    
    @ObservedObject private var achievedTodosViewModel = AchievedTodosViewModel()
    
    @State private var isShowEditSheet = false
    @State private var isConfirming = false
    @State private var todoUnderConfirm: Todo? = nil
    
    var body: some View {
        NavigationView {
            
            List {
                
                ForEach(achievedTodosViewModel.days) { day in
                    Section(header: Text("\(DayConverter.toStringUpToWeekday(from: day.ymd))")) {
                        ForEach(day.achievedTodos) { todo in
                            Button(action: {
                                isShowEditSheet.toggle()
                            }) {
                                HStack {
                                    Text(DayConverter.toTimeString(from: todo.achievedAt!))
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
                }
            }
            
            .confirmationDialog("areYouSureYouWantToDeleteThisTodo", isPresented: $isConfirming, titleVisibility: .visible) {
                Button("deleteTodo", role: .destructive) {
                    FireTodo.delete(id: todoUnderConfirm!.id, achievedAt: todoUnderConfirm!.achievedAt)
                }
            } message: {
                Text(todoUnderConfirm != nil ? todoUnderConfirm!.content : "")
            }
            
            .navigationTitle("history")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
