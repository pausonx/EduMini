//
//  LoginClass.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 07/08/2023.
//

import Foundation

import FirebaseAuth

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    static let shared = FirebaseManager()
        
    @Published var signedIn = false // Zmienna instancji
        
    var isSignedIn: Bool { // Zmienna instancji
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                //Success
                self?.signedIn = true
            }
            
        }
    }
    
    func signUp(email: String, password: String, name: String, age: String, pin: String) {
        auth.createUser(withEmail: email, password: password)  { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            guard (FirebaseManager.shared.auth.currentUser?.uid) != nil else { return }
            self?.storeUserInformation(email: email, name: name, age: age, pin: pin)
                        
            DispatchQueue.main.async {
                //Success
                self?.signedIn = true
            }
        }
    }

    
    private func storeUserInformation(email: String, name: String, age: String, pin: String){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        let userData = ["email": email, "uid": uid, "name" : name, "age": age, "pin": pin] as [String : Any]
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
}
