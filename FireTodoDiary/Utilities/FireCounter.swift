//
//  FireCount.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/21.
//

import Firebase

class FireCounter {
    
    // 特定の日の各時間に達成された、Todoの数
    static func readCountsInDay(year: Int, month: Int, day: Int, completion: (([Int]) -> Void)?) {
        // Document ID
        let achievedYmd = String(format: "%04d", year) + String(format: "%02d", month) + String(format: "%02d", day)
        let userId = CurrentUser.userId()
        let documentId = achievedYmd + userId

        let db = Firestore.firestore()
        db.collection("counters")
            .document(documentId)
            .getDocument { (document, error) in
                if let document = document, document.exists {
                    print("HELLO! Success! Read \(documentId). size: 1")
                    // TODO: Create countsInDay array.
                    var countsInDay: [Int] = []
                    for index in 0 ..< 23 {
                        let count = document.get(String(index)) as? Int ?? 0
                        countsInDay.append(count)
                    }
                    completion?(countsInDay)
                } else {
                    print("HELLO! Success! \(documentId) does not exists. size: 0")
                    let countsInDay: [Int] = []
                    completion?(countsInDay)
                }
            }
    }
    
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
    
    static func increment(achievedAt: Date) {
        incrementInDay(achievedAt: achievedAt)
        incrementInMonth(achievedAt: achievedAt)
        incrementInYear(achievedAt: achievedAt)
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
    
    static func incrementInMonth(achievedAt: Date) {
        // Document ID
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: achievedAt)
        let year = dateComponents.year!
        let month = dateComponents.month!
        let achievedYm = String(format: "%04d", year) + String(format: "%02d", month)
        let userId = CurrentUser.userId()
        let documentId = achievedYm + userId
        // Field name
        let field = String(dateComponents.day!)
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
    
    static func incrementInYear(achievedAt: Date) {
        // Document ID
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: achievedAt)
        let year = dateComponents.year!
        let achievedY = String(format: "%04d", year)
        let userId = CurrentUser.userId()
        let documentId = achievedY + userId
        // Field name
        let field = String(dateComponents.month!)
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
    
    static func decrement(achievedAt: Date) {
        decrementInDay(achievedAt: achievedAt)
        decrementInMonth(achievedAt: achievedAt)
        decrementInYear(achievedAt: achievedAt)
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
    
    static func decrementInMonth(achievedAt: Date) {
        // Document ID
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: achievedAt)
        let year = dateComponents.year!
        let month = dateComponents.month!
        let achievedYm = String(format: "%04d", year) + String(format: "%02d", month)
        let userId = CurrentUser.userId()
        let documentId = achievedYm + userId
        // Field name
        let field = String(dateComponents.day!)
        update(id: documentId, fieldToDecrement: field)
    }
    
    static func decrementInYear(achievedAt: Date) {
        // Document ID
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: achievedAt)
        let year = dateComponents.year!
        let achievedY = String(format: "%04d", year)
        let userId = CurrentUser.userId()
        let documentId = achievedY + userId
        // Field name
        let field = String(dateComponents.month!)
        update(id: documentId, fieldToDecrement: field)
    }
}
