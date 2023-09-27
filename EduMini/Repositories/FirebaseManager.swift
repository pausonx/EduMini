//
//  FirebaseManager.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 07/08/2023.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

class FirebaseManager: NSObject {
    
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    var currentUser: AppUser?
    
    static let shared = FirebaseManager()
    
    override init() {
        if FirebaseApp.app() == nil {
              FirebaseApp.configure()
        }
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
    
}
