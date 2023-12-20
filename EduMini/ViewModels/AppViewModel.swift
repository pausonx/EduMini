//
//  AppViewModel.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 07/08/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    static let shared = FirebaseManager()
        
    @Published var signedIn = false
    @Published var loginError = ""
        
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                self.loginError = "Nieprawidłowy email lub hasło"
                print("Error signing in: \(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                self.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String, name: String, nick: String, age: String, pin: String) {
        auth.createUser(withEmail: email, password: password)  { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            guard (FirebaseManager.shared.auth.currentUser?.uid) != nil else { return }
            self?.storeUserInformation(email: email, name: name, nick: nick, age: age, pin: pin)
                        
            DispatchQueue.main.async {
                //Success
                self?.signedIn = true
            }
        }
    }

    
    private func storeUserInformation(email: String, name: String, nick: String, age: String, pin: String){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        let userData = ["email": email, "uid": uid, "name" : name, "nick" : nick, "age": age, "pin": pin, "emailVisible": "yes", "ageVisible": "yes", "points": "0"] as [String : Any]
        FirebaseManager.shared.firestore.collection("users")
                .document(uid).setData(userData) { err in
                    if let err = err {
                        print(err)
                        print("\(err)")
                        return
                    }
                    
                    print("Success")
                }
    }
    
    func signOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
    
    func isEmailUnique(_ email: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        usersCollection.whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Błąd podczas sprawdzania unikalności e-maila: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let documents = querySnapshot?.documents, !documents.isEmpty {
                // E-mail jest już w użyciu
                completion(false)
            } else {
                // E-mail jest unikalny
                completion(true)
            }
        }
    }
    
    func isNickUnique(_ nick: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        usersCollection.whereField("nick", isEqualTo: nick).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Błąd podczas sprawdzania unikalności nicku: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let documents = querySnapshot?.documents, !documents.isEmpty {
                // Nick jest już w użyciu
                completion(false)
            } else {
                // Nick jest unikalny
                completion(true)
            }
        }
    }
}
