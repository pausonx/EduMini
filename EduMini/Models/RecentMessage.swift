//
//  RecentMessage.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 09/10/2023.
//

import Foundation
import FirebaseFirestore

struct RecentMessage: Identifiable {
    
    var id: String { documentId }
    
    let documentId: String
    let text, fromId, toId: String
    let name, nick: String
    let timestamp: Timestamp
    
    init(documentId: String, data: [String: Any]){
        self.documentId = documentId
        self.text = data[FirebaseConstants.text] as? String ?? ""
        self.fromId = data[FirebaseConstants.fromId] as? String ?? ""
        self.toId = data[FirebaseConstants.toId] as? String ?? ""
        self.name = data[FirebaseConstants.name] as? String ?? ""
        self.nick = data[FirebaseConstants.nick] as? String ?? ""
        self.timestamp = data[FirebaseConstants.timestamp] as? Timestamp ?? Timestamp(date: Date())
    }
    
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        let timeInterval = TimeInterval(timestamp.seconds)
        return formatter.localizedString(for: Date(timeIntervalSince1970: timeInterval), relativeTo: Date())
    }
    
}

