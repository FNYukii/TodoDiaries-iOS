//
//  SecondView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct SecondView: View {
    
    @ObservedObject private var daysViewModel = DaysViewModel()
    
    @State private var achievedDays: [Int] = []
    @State private var isShowEditSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(daysViewModel.achievedDays, id: \.self){ achievedDay in
                    AchievedTodoSection(achievedDay: achievedDay)
                }
            }
            
            .navigationTitle("achieved")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
