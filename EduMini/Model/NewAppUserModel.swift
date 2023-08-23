//
//  NewAppUserModel.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 07/08/2023.
//

import Foundation
import Firebase

class NewAppUsersModel: ObservableObject {
    
    @Published var appUser: AppUser?
    @Published var users = [AppUser]()
    @Published var errorMessage = ""
    
    init() {
        fetchCurrentUser(settings: nil) 
        fetchAllUsers()
    }
    
    internal func fetchCurrentUser(settings: ParentalControlSettings?) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user:", error)
                return
            }
            
            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return
                
            }
            
            self.appUser = AppUser(data: data)
            
            if let chatValue = data["chat"] as? String, let settings = settings {
                settings.isActiveChat = chatValue == "yes"
            }

            if let emailVisibleValue = data["emailVisible"] as? String, let settings = settings {
                settings.isActiveEmail = emailVisibleValue == "yes"
            }

            if let ageVisibleValue = data["ageVisible"] as? String, let settings = settings {
                settings.isActiveAge = ageVisibleValue == "yes"
            }
            
            FirebaseManager.shared.currentUser = self.appUser
        }
    }
    
    internal func fetchAllUsers() {
        FirebaseManager.shared.firestore.collection("users")
            .getDocuments { documentsSnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch users: \(error)"
                    print("Failed to fetch users: \(error)")
                    return
                }
                
                documentsSnapshot?.documents.forEach({ snapshot in
                    let data = snapshot.data()
                    let user = AppUser(data: data)
                    if user.uid != FirebaseManager.shared.auth.currentUser?.uid {
                        self.users.append(.init(data: data))
                    }
                    
                })
            }
    }
    
    func saveParentalControlSettings(_ settings: ParentalControlSettings) {
        let db = Firestore.firestore()

        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("users").document(userID).setData([
            "chat": settings.isActiveChat ? "yes" : "no",
            "emailVisible": settings.isActiveEmail ? "yes" : "no",
            "ageVisible": settings.isActiveAge ? "yes" : "no"
        ], merge: true) { error in
            if let error = error {
                print("Error updating parental control settings: \(error)")
            } else {
                print("Parental control settings updated successfully!")
            }
        }
    }
}
