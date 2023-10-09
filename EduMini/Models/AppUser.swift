//
//  AppUser.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 07/08/2023.
//

import Foundation

struct AppUser: Identifiable {
    var id: String { uid }
    let uid, email, name, age, pin, emailVisible, ageVisible, points: String
    
    init(data: [String: Any]){
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.age = data["age"] as? String ?? ""
        self.pin = data["pin"] as? String ?? ""
        self.emailVisible = data["emailVisible"] as? String ?? ""
        self.ageVisible = data["ageVisible"] as? String ?? ""
        self.points = data["points"] as? String ?? ""
    }
}
