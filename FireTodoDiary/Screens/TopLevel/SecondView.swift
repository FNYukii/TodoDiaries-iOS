//
//  SecondView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct SecondView: View {
            
    @ObservedObject private var achievedDaysViewModel = AchievedDaysViewModel()
    @State private var limit = 20
    
    init() {
        achievedDaysViewModel.read(limit: limit)
    }
    
    var body: some View {
        NavigationView {
            
            ZStack {
                if !achievedDaysViewModel.isLoaded {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
                
                if achievedDaysViewModel.isLoaded {
                    List {
                        ForEach(achievedDaysViewModel.days) { day in
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
                                    limit += 5
                                    achievedDaysViewModel.read(limit: limit)
                                }
                            Spacer()
                        }
                        .listRowBackground(Color.clear)
                    }
                    
                    if achievedDaysViewModel.days.count == 0 {
                        VStack {
                            Text("no_todo_achieved_yet")
                            Text("when_you_complete_todo_you_will_see_it_here")
                        }
                        .foregroundColor(.secondary)
                    }
                    
                }
            }
            
            .navigationTitle("history")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
