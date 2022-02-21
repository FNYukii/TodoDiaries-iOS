//
//  FireCount.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/21.
//

import Firebase

class FireCount {
    
    static func incrementAtHourInDay(achievedAt: DateComponents) {
        // Document ID
        let year = achievedAt.year!
        let month = achievedAt.month!
        let day = achievedAt.day!
        let documentId = String(format: "%04d", year) + String(format: "%02d", month) + String(format: "%02d", day)
        
        // Field name
        let field = String(achievedAt.hour!)
        
        let db = Firestore.firestore()
        db.collection("countsInDay")
            .document(documentId)
            .updateData([
                field: FieldValue.increment(1.0) // インクリメント
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
    }
    
    
    
    
}
