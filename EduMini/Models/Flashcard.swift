//
//  Flashcard.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 10/10/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Flashcard: Codable, Identifiable {
    @DocumentID var id: String?
    var question: String
    var answer: String
    var topic: String
    var fliping: Bool = false
    var userId: String?
}
