//
//  SecondView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct SecondView: View {
    
    @ObservedObject private var daysViewModel = DaysViewModel()
        
    var body: some View {
        NavigationView {
            
            ZStack {
                List {
                    ForEach(daysViewModel.achievedDays, id: \.self){ achievedDay in
                        AchievementSection(achievedDay: achievedDay)
                    }
                }
                
                if daysViewModel.achievedDays.count == 0 && daysViewModel.isLoaded {
                    VStack {
                        Text("まだ達成済みのTodoはありません")
                        Text("Todoを達成するとここに表示されます")
                    }
                    .foregroundColor(.secondary)
                }
            }
            
            .navigationTitle("history")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ShowAccountViewButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // TODO: Open datePicker
                    }) {
                        Image(systemName: "calendar")
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
