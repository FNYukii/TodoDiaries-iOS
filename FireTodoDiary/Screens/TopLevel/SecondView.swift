//
//  SecondView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct SecondView: View {
    
//    @ObservedObject private var achievedTodosViewModel = AchievedTodosViewModel()
    
    @State private var days: [Day] = []
    @State private var isLoaded = false
    
    @State private var isShowEditSheet = false
    @State private var isConfirming = false
    @State private var todoUnderConfirm: Todo? = nil
    
    var body: some View {
        NavigationView {
            
            ZStack {
                if !isLoaded {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
                
                if isLoaded {
                    List {
                        ForEach(days) { day in
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
                                        EditView(todo: todo)
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
                    
                    if days.count == 0 {
                        VStack {
                            Text("no_todo_achieved_yet")
                            Text("when_you_complete_todo_you_will_see_it_here")
                        }
                        .foregroundColor(.secondary)
                    }
                    
                }
            }
            .onAppear(perform: load)
            
            
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
    
    private func load() {
        FireTodo.achievedTodos { value in
            withAnimation {
                self.days = value
                self.isLoaded = true
            }
           
        }
    }
}
