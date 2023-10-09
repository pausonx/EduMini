//
//  ChatMessage.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 09/10/2023.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct ChatMessage: Identifiable {
    
    var id: String { documentId }
    
    let documentId: String
    let fromId, toId, text: String
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.fromId = data[FirebaseConstants.fromId] as? String ?? ""
        self.toId = data[FirebaseConstants.toId] as? String ?? ""
        self.text = data[FirebaseConstants.text] as? String ?? ""
    }
}
