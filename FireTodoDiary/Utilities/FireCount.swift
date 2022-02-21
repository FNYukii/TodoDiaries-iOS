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
        
        // Check document exists
        let db = Firestore.firestore()
        db.collection("countsInDays")
            .document(documentId)
            .getDocument { (document, error) in
                if let document = document, document.exists {
                    print("HELLO! Success! \(documentId) existeds.")
                    
                    // Update
                    db.collection("countsInDays")
                        .document(documentId)
                        .updateData([
                            field: FieldValue.increment(1.0) // インクリメント
                        ]) { err in
                            if let err = err {
                                print("HELLO! Fail! Error updating document: \(err)")
                            } else {
                                print("HELLO! Success! Updated count")
                            }
                        }
                    
                } else {
                    print("HELLO! Success! \(documentId) does not exist.")
                    
                    // Create
                    db.collection("countsInDays")
                        .document(documentId)
                        .setData([
                            field: 1
                        ]) { err in
                            if let err = err {
                                print("HELLO! Fail! Error writing document. \(err)")
                            } else {
                                print("HELLO! Success! Added Todo.")
                            }
                        }
                    
                }
            }
        
        
    }
}
