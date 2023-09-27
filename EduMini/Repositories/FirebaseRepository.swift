//
//  FirebaseRepository.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 27/09/2023.
//

import Firebase
import FirebaseFirestore

class FirebaseRepository {
    static let shared = FirebaseRepository()
    
    private init() {}
    
    func configure() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
    
    func getCurrentUser() -> AppUser? {
        return FirebaseManager.shared.currentUser
    }
    
    func saveSetting(_ settingName: String, isActive: Bool, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("users").document(userID).setData([settingName: isActive ? "yes" : "no"], merge: true) { error in
            completion(error)
        }
    }
    
    func updateUserData(_ dataName: String, dataValue: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("users").document(userID).setData([
            dataName: dataValue
        ], merge: true) { error in
            completion(error)
        }
    }
    
}
