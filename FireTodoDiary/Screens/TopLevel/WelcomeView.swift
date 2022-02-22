//
//  WelcomeView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var isShowSheet = false
    @State private var selection = 0
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.label
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.7)
    }
    
    var body: some View {
        
        VStack {
            TabView(selection: $selection.animation()) {
                VStack {
                    Image(decorative: "image01")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                        .opacity(0.7)
                    Text("Todoを管理しよう")
                        .font(.title3)
                        .padding(.top)
                    Text("やりたいこと・やるべきことをアプリに保存し、管理しましょう。")
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .padding(.top, -10)
                }
                .tag(0)
                
                VStack {
                    Image(decorative: "image02")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                        .opacity(0.7)
                    Text("Todoを達成しよう")
                        .font(.title3)
                        .padding(.top)
                    Text("Todoを達成したらアプリ内で達成済みに変更しましょう。達成したTodoは後から振り返ることができます。")
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .padding(.top, -10)
                }
                .tag(1)
                
                VStack {
                    Image(decorative: "image03")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                        .opacity(0.7)
                    Text("統計を見よう")
                        .font(.title3)
                        .padding(.top)
                    Text("Todoを達成した時間や、日別・月別の達成数をグラフで確認できます。")
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .padding(.top, -10)
                }
                .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .frame(height: 400)
            
            Button(action: {
                isShowSheet.toggle()
            }) {
                Text("サインインして始める")
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
