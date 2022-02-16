//
//  ThirdView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct ThirdView: View {
    
    @State private var selection = 0
    
    @State private var unachievedTodoCount = 0
    @State private var achievedTodoCount = 0
    
    @State private var isShowAccountSheet = false
        
    var body: some View {
        NavigationView {
            List {
                
                Section(header: Text("charts")) {
                    TabView(selection: $selection) {
                        ForEach(-2 ..< 3){ index in
                            OnePage(monthOffset: index)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 300)
                }
                
                Section(header: Text("stats")) {
                    HStack {
                        Text("todos")
                        Spacer()
                        Text(String(unachievedTodoCount))
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("achievements")
                        Spacer()
                        Text(String(achievedTodoCount))
                            .foregroundColor(.secondary)
                    }
                }
                
            }
            
            .sheet(isPresented: $isShowAccountSheet) {
                AccountView()
            }
            
            .navigationTitle("stats")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isShowAccountSheet.toggle()
                    }) {
                        Image(systemName: "person.crop.circle")
                            .font(.title3)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        .onAppear {
            // Read unachieved todo count
            FirestoreTodo.readCount(isAchieved: false) {count in
                unachievedTodoCount = count
            }
            
            // Read unachieved todo count
            FirestoreTodo.readCount(isAchieved: true) {count in
                achievedTodoCount = count
            }
        }
    }
}
