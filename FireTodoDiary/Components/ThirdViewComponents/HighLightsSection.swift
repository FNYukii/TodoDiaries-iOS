//
//  HighLightsSection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/17.
//

import SwiftUI

struct HighLightsSection: View {
    
    var body: some View {
        Section(header: Text("highlights")) {
            HStack {
                Text("todos")
                Spacer()
                Text("4")
                    .foregroundColor(.secondary)
            }
            HStack {
                Text("achievements")
                Spacer()
                Text("2")
                    .foregroundColor(.secondary)
            }
        }
    }
}
