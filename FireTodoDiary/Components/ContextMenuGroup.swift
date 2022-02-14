//
//  ContextMenuGroup.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/14.
//

import SwiftUI

struct ContextMenuGroup: View {
    
    let isPinned: Bool
    let isAchieved: Bool
    
    init(isPinned: Bool = false, isAchieved: Bool = false) {
        self.isPinned = isPinned
        self.isAchieved = isAchieved
    }
    
    var body: some View {
        Group {
            
            if !isPinned {
                Button(action: {
                    // TODO: isPinned = true
                }) {
                    Label("固定する", systemImage: "pin")
                }
            }
            
            if isPinned {
                Button(action: {
                    // TODO: isPinned = false
                }) {
                    Label("固定を解除", systemImage: "pin.slash")
                }
            }
            
            if !isAchieved {
                Button(action: {
                    // TODO: isAchieved = true
                }) {
                    Label("達成済みにする", systemImage: "checkmark")
                }
            }
            
            if isAchieved {
                Button(action: {
                    // TODO: isAchieved = false
                }) {
                    Label("未達成に戻す", systemImage: "xmark")
                }
            }
            
            Button(role: .destructive) {
                // TODO: Delete document
            } label: {
                Label("削除", systemImage: "trash")
            }
        }
    }
}
