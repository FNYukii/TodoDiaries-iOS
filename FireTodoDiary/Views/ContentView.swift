//
//  ContentView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var todoViewModel = TodoViewModel()
    
    
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(todoViewModel.todos){todo in
                    Text(todo.content)
                }
            }
            
            .navigationBarTitle("Todos")
            
        }
        
        
        
        
        
    }
}
