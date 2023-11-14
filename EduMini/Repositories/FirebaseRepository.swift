//
//  FirebaseRepository.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 27/09/2023.
//

import Firebase
import FirebaseFirestore

class FirebaseRepository: ObservableObject {
    static let shared = FirebaseRepository()

    @Published var currentUser: AppUser?

    private init() {}

    func configure() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }

    func getCurrentUser() -> AppUser? {
        return currentUser
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

    func updatePoints(_ points: Int, completion: @escaping (Error?) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "FirebaseRepository", code: 400, userInfo: [NSLocalizedDescriptionKey: "User not logged in."]))
            return
        }

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userID)

        userRef.getDocument { (document, error) in
            if let error = error {
                completion(error)
            } else if let document = document, document.exists {
                if var currentPoints = document.data()?["points"] as? String {
                    // Spróbuj przekształcić ciąg znaków na liczbę
                    if let currentPointsValue = Int(currentPoints) {
                        currentPoints = "\(currentPointsValue + points)"

                        userRef.setData(["points": currentPoints], merge: true) { error in
                            completion(error)
                        }
                    } else {
                        completion(NSError(domain: "FirebaseRepository", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to convert points to an integer."]))
                    }
                } else {
                    completion(NSError(domain: "FirebaseRepository", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve current points from the document."]))
                }
            } else {
                completion(NSError(domain: "FirebaseRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "User document not found."]))
            }
        }
    }

}
