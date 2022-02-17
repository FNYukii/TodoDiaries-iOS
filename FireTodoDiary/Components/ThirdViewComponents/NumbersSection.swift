//
//  HighLightsSection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/17.
//

import SwiftUI

struct NumbersSection: View {
        
    var body: some View {
        Section(header: Text("theNumberOfTodos")) {
            HStack {
                Text("unachieved")
                Spacer()
                Text("4")
                    .foregroundColor(.secondary)
            }
            HStack {
                Text("achieved")
                Spacer()
                Text("41")
                    .foregroundColor(.secondary)
            }
            HStack {
                Text("total")
                Spacer()
                Text("45")
                    .foregroundColor(.secondary)
            }
        }
    }
}
