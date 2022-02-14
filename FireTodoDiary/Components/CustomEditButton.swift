//
//  CustomEditButton.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct CustomEditButton: View {
    
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        Button(action: {
            withAnimation {
                if editMode?.wrappedValue.isEditing == true {
                    editMode?.wrappedValue = .inactive
                } else {
                    editMode?.wrappedValue = .active
                }
            }
        }){
            if editMode?.wrappedValue.isEditing == true {
                Text("done")
            } else {
                Text("edit")
            }
        }
    }
}
