//
//  SecondView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct SecondView: View {
        
    @State private var days: [Day] = []
    @State private var limit: Int? = 50
    @State private var isLoaded = false
    
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
                                    TodoRow(todo: todo)
                                }
                            }
                        }
                        
                        HStack {
                            Spacer()
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .onAppear {
                                    limit = nil
                                    load()
                                }
                            Spacer()
                        }
                        .listRowBackground(Color.clear)
                        
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
            
            .navigationTitle("history")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func load() {
        FireTodo.achievedTodos(limit: limit) { days in
            withAnimation {
                self.days = days
                self.isLoaded = true
            }
        }
    }
}
