//
//  WelcomeView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var isShowSheet = false
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.label
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.7)
    }
    
    var body: some View {
        
        VStack {
            TabView {
                VStack {
                    Image(decorative: "image01")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                        .opacity(0.8)
                    Text("manage_your_todo")
                        .font(.title3)
                        .padding(.top)
                    Text("save_what_you_want_to_do_and_what_you_need_to_do_in_this_app_and_manage_it_efficiently")
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .padding(.top, -10)
                }
                
                VStack {
                    Image(decorative: "image02")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                        .opacity(0.8)
                    Text("achieve_your_todo")
                        .font(.title3)
                        .padding(.top)
                    Text("once_you_have_achieved_todo_change_it_to_Achieved_within_the_app_You_can_look_back_on_the_achievements_of_todo_later")
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .padding(.top, -10)
                }
                
                VStack {
                    Image(decorative: "image03")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                        .opacity(0.8)
                    Text("lets_see_the_stats")
                        .font(.title3)
                        .padding(.top)
                    Text("you_can_check_the_time_when_you_achieved_todo_and_the_number_of_achievements_by_day_and_month_in_the_graph")
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .padding(.top, -10)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .frame(height: 400)
            
            Button(action: {
                isShowSheet.toggle()
            }) {
                Text("sign_in_to_start")
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 48)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(48)
        }
        
        .sheet(isPresented: $isShowSheet) {
            FirebaseAuthView()
        }
        
    }
}
