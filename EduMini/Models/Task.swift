//
//  Task.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 27/09/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Task: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var completed: Bool
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
}

#if DEBUG
let testDataTask = [
    Task(title: "Test1", completed: true),
    Task(title: "Test2", completed: false),
    Task(title: "Test3", completed: false),
    Task(title: "Test4", completed: true)
]
#endif
