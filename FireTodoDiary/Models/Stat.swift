//
//  Stat.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/16.
//

import Firebase

struct Stat {
    let id: String
    let achievedTodoCount: [String: Int]
    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        self.achievedTodoCount = document.get("achievedTodoCounts") as! [String: Int]
    }
}
