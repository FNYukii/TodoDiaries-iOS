//
//  HighlightsSection.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/18.
//

import SwiftUI

struct HighlightsSection: View {
    var body: some View {
        Section(header: Text("highlights")) {
            VStack(alignment: .leading) {
                Text("昨日は一昨日よりも多くのTodoを達成しました")
            }
        }
    }
}
