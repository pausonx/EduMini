//
//  QuestionViewModel.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 31/10/2023.
//

import Foundation
import Firebase

class QuestionViewModel: ObservableObject {
    
    @Published var questions: [Question] = []
    
    func getQuestions(set: String, level: String) {
        let db = Firestore.firestore()
        let query = db.collection(set)
        
        query.getDocuments { (snap, err) in
            guard let data = snap else { return }
            
            DispatchQueue.main.async {
                var allQuestions: [Question] = data.documents.compactMap { (doc) -> Question? in
                    return try? doc.data(as: Question.self)
                }
                
                if level == "L4" {
                    // Jeśli level to "L4", pobierz wszystkie pytania ze wszystkich poziomów
                    db.collection(set).getDocuments { (snap, err) in
                        guard let allLevelsData = snap else { return }
                        let allLevelsQuestions = allLevelsData.documents.compactMap { (doc) -> Question? in
                            return try? doc.data(as: Question.self)
                        }
                        allQuestions += allLevelsQuestions
                    }
                } else {
                    // Jeśli level to inny niż "L4", przefiltruj pytania na podstawie poziomu
                    allQuestions = allQuestions.filter { $0.level == level }
                }
                
                allQuestions.shuffle()
                
                // Ogranicz ilość pytań do 10
                let limitedQuestions = Array(allQuestions.prefix(10))
                
                self.questions = limitedQuestions
            }
        }
    }

}
