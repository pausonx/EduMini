//
//  Question.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 31/10/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Question: Codable,Identifiable  {
    var id: String?
    var question: String?
    var optionA: String?
    var optionB: String?
    var optionC: String?
    var optionD: String?
    var answer: String?
    var level: String?
    var userId: String?
    
    var isSubmitted = false
    var completed = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case question
        case optionA = "a"
        case optionB = "b"
        case optionC = "c"
        case optionD = "d"
        case answer
        case level
        case userId
    }
}
