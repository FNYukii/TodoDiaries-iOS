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
    @State private var isShowAccountSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(daysViewModel.achievedDays, id: \.self){ achievedDay in
                    AchievementSection(achievedDay: achievedDay)
                }
            }
            
            .sheet(isPresented: $isShowAccountSheet) {
                AccountView()
            }
            
            .navigationTitle("achievements")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isShowAccountSheet.toggle()
                    }) {
                        Image(systemName: "person.crop.circle")
                            .font(.title2)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
