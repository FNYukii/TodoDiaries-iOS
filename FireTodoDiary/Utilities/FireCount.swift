//
//  FireCount.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/21.
//

import Firebase

class FireCount {
    
    static func incrementAtHourInDay(achievedAt: Date) {
        // Document ID
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: achievedAt)
        let year = dateComponents.year!
        let month = dateComponents.month!
        let day = dateComponents.day!
        let achievedYmd = String(format: "%04d", year) + String(format: "%02d", month) + String(format: "%02d", day)
        let userId = CurrentUser.userId()
        let documentId = achievedYmd + userId
        
        // Field name
        let field = String(dateComponents.hour!)
        
        // Read
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
