//
//  SecondView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct SecondView: View {
            
    @ObservedObject private var achievedDaysViewModel = AchievedDaysViewModel()
    @State private var limit = 50
    
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
                        ForEach(achievedDaysViewModel.achievedDays) { achievedDay in
                            Section(header: Text("\(DayConverter.toStringUpToWeekday(year: achievedDay.year, month: achievedDay.month, day: achievedDay.day))")) {
                                ForEach(achievedDay.achievedTodos) { todo in
                                    TodoRow(todo: todo)
                                }
                            }
                        }
                        
                        Button(action: {
                            limit += 50
                            achievedDaysViewModel.read(limit: limit)
                        }) {
                            if limit == achievedDaysViewModel.documents.count {
                                Text("load_more")
                            }
                        }
                        .listRowBackground(Color.clear)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    if achievedDaysViewModel.achievedDays.count == 0 {
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
