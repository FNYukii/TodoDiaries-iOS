//
//  ShowAccountViewButton.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/17.
//

import SwiftUI

struct ShowAccountViewButton: View {
    
    @State private var isShowAccountSheet = false
    
    var body: some View {
        Button(action: {
            isShowAccountSheet.toggle()
        }) {
            Image(systemName: "person.crop.circle")
                .font(.title2)
        }
        
        .sheet(isPresented: $isShowAccountSheet) {
            AccountView()
        }
        
    }
}
