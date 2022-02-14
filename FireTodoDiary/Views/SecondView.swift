//
//  SecondView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct SecondView: View {
    
    @ObservedObject private var achievedTodoViewModel = TodoViewModel(isAchieved: true)
    
    @State private var achievedDays: [Int] = []
    @State private var isShowEditSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(achievedDays, id: \.self){ achievedDay in
                    AchievedTodoSection(achievedDay: achievedDay)
                }
            }
            
            .onAppear(perform: loadAchievedDays)
            .onChange(of: achievedTodoViewModel.todos) { _ in
                loadAchievedDays()
            }
            
            .navigationTitle("achieved")
        }
    }
    
    private func loadAchievedDays() {
        // 達成済みの全てのTodo
        let achievedTodos = achievedTodoViewModel.todos
        // Todo達成日の配列 [20220213, 20220214, ...]
        var newAchievedDays: [Int] = []
        for achievedTodo in achievedTodos {
            let achievedDay = achievedTodo.achievedDay!
            newAchievedDays.append(achievedDay)
        }
        // 配列から重複した要素を削除
        let orderdSet = NSOrderedSet(array: newAchievedDays)
        newAchievedDays = orderdSet.array as! [Int]
        print("HELLO newAchievedDays: \(newAchievedDays)")
        // プロパティに反映
        self.achievedDays = newAchievedDays
    }
}
