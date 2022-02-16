//
//  Fire.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/15.
//

import Firebase

class FirestoreTodo {
    
    static func readCount(isAchieved: Bool, completion: ((Int) -> Void)?) {
        let userId = CurrentUser.userId()
        let db = Firestore.firestore()
        db.collection("todos")
            .whereField("userId", isEqualTo: userId)
            .whereField("isAchieved", isEqualTo: isAchieved)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error getting documents: \(err)")
                    return
                }
                print("HELLO! Success! Read documents in todos")
                if let querySnapshot = querySnapshot {
                    let todoCount = querySnapshot.documents.count
                    completion?(todoCount)
                }
            }
    }
    
    static func create(content: String, isPinned: Bool, isAchieved: Bool, achievedAt: Date) {
        // user id
        let userId = CurrentUser.userId()
        
        // Add new document
        let db = Firestore.firestore()
        db.collection("todos")
            .addDocument(data: [
                "userId": userId,
                "content": content,
                "createdAt": Date(),
                "isPinned": !isAchieved ? isPinned : false,
                "isAchieved": isAchieved,
                "achievedAt": (isAchieved ? achievedAt : nil) as Any,
                "achievedDay": (isAchieved ? Day.toInt(from: achievedAt) : nil) as Any
            ]) { error in
                if let error = error {
                    print("HELLO! Fail! Error adding new document: \(error)")
                } else {
                    print("HELLO! Success! Added new document to todos")
                }
            }
    }
    
    static func update(id: String, content: String, isPinned: Bool, isAchieved: Bool, achievedAt: Date) {
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .updateData([
                "content": content,
                "isPinned": !isAchieved ? isPinned : false,
                "isAchieved": isAchieved,
                "achievedAt": (isAchieved ? achievedAt : nil) as Any,
                "achievedDay": (isAchieved ? Day.toInt(from: achievedAt) : nil) as Any
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating document: \(err)")
                } else {
                    print("HELLO! Success! Updated document")
                }
            }
    }
    
    static func update(id: String, isPinned: Bool) {
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .updateData([
                "isPinned": isPinned
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating document: \(err)")
                } else {
                    print("HELLO! Success! Updated document")
                }
            }
    }
    
    static func update(id: String, isAchieved: Bool) {
        let now = Date()
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .updateData([
                "isPinned": false,
                "isAchieved": isAchieved,
                "achievedAt": (isAchieved ? now : nil) as Any,
                "achievedDay": (isAchieved ? Day.toInt(from: now) : nil) as Any
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating document: \(err)")
                } else {
                    print("HELLO! Success! Updated document")
                }
            }
    }
    
    static func delete(id: String) {
        let db = Firestore.firestore()
        db.collection("todos")
            .document(id)
            .delete() { err in
                if let err = err {
                    print("HELLO! Fail! Error removing document: \(err)")
                } else {
                    print("HELLO! Success! Removed document")
                }
            }
    }
}
