//
//  ParentalControlViewModel.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 27/09/2023.
//

import Firebase

class ParentalControlViewModel: ObservableObject {
    
    @Published var appUser: AppUser?
    @Published var users = [AppUser]()
    @Published var errorMessage = ""
    
    private let firebaseRepository = FirebaseRepository.shared
    
    func saveChatSetting(_ isActive: Bool) {
        firebaseRepository.saveSetting("chat", isActive: isActive) { error in
            if let error = error {
                self.errorMessage = "Error saving chat setting: \(error)"
                print("Error saving chat setting: \(error)")
            } else {
                print("Chat setting saved successfully!")
            }
        }
    }
    
    func saveEmailSetting(_ isActive: Bool) {
        firebaseRepository.saveSetting("emailVisible", isActive: isActive) { error in
            if let error = error {
                self.errorMessage = "Error saving email setting: \(error)"
                print("Error saving email setting: \(error)")
            } else {
                print("Email setting saved successfully!")
            }
        }
    }
    
    func saveAgeSetting(_ isActive: Bool) {
        firebaseRepository.saveSetting("ageVisible", isActive: isActive) { error in
            if let error = error {
                self.errorMessage = "Error saving age setting: \(error)"
                print("Error saving age setting: \(error)")
            } else {
                print("Age setting saved successfully!")
            }
        }
    }
    
    func updateName(_ name: String) {
        firebaseRepository.updateUserData("name", dataValue: name) { error in
            if let error = error {
                self.errorMessage = "Error updating name: \(error)"
                print("Error updating name: \(error)")
            } else {
                print("Name updated successfully!")
            }
        }
    }
    
    func updateAge(_ age: String) {
        firebaseRepository.updateUserData("age", dataValue: age) { error in
            if let error = error {
                self.errorMessage = "Error updating age: \(error)"
                print("Error updating age: \(error)")
            } else {
                print("Age updated successfully!")
            }
        }
    }
}
