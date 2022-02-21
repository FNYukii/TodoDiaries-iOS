//
//  FireCount.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/21.
//

import Firebase

class FireCounter {
    
    static func create(id: String, field: String) {
        let userId = CurrentUser.userId()
        let db = Firestore.firestore()
        db.collection("counters")
            .document(id)
            .setData([
                "userId": userId,
                field: 1
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error writing document. \(err)")
                } else {
                    print("HELLO! Success! Added Todo.")
                }
            }
    }
    
    static func update(id: String, fieldToIncrement: String) {
        let db = Firestore.firestore()
        db.collection("counters")
            .document(id)
            .updateData([
                fieldToIncrement: FieldValue.increment(1.0)
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating document: \(err)")
                } else {
                    print("HELLO! Success! Updated count")
                }
            }
    }
    
    static func update(id: String, fieldToDecrement: String) {
        let db = Firestore.firestore()
        db.collection("counters")
            .document(id)
            .updateData([
                fieldToDecrement: FieldValue.increment(-1.0)
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating document: \(err)")
                } else {
                    print("HELLO! Success! Updated count")
                }
            }
    }
    
    static func incrementInDay(achievedAt: Date) {
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
        db.collection("counters")
            .document(documentId)
            .getDocument { (document, error) in
                if let document = document, document.exists {
                    print("HELLO! Success! \(documentId) existeds. size: 1")
                    update(id: documentId, fieldToIncrement: field)
                } else {
                    print("HELLO! Success! \(documentId) does not exist. size: 0")
                    create(id: documentId, field: field)
                }
            }
    }
    
    static func decrementInDay(achievedAt: Date) {
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
        update(id: documentId, fieldToDecrement: field)
    }
}
