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
            List {
                ForEach(daysViewModel.achievedDays, id: \.self){ achievedDay in
                    AchievementSection(achievedDay: achievedDay)
                }
            }
            
            .navigationTitle("achievements")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ShowAccountViewButton()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
