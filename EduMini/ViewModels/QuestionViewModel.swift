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
    @Published var userQuestions: [Question] = []
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    let userId = Auth.auth().currentUser?.uid

    
    func getQuestions(set: String, level: String) {
        let db = Firestore.firestore()
        let query = db.collection(set)
        let userId = Auth.auth().currentUser?.uid

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
                } else if level == "L0" {
                    // Jeśli level to "L0", przefiltruj pytania na podstawie użytkownika
                    allQuestions = allQuestions.filter { question in
                        if let questionUserId = question.userId {
                            return questionUserId == userId
                        }
                        return false
                    }
                } else {
                    // Jeśli level to inny niż "L4" lub "L0", przefiltruj pytania na podstawie poziomu
                    allQuestions = allQuestions.filter { $0.level == level }
                }

                allQuestions.shuffle()

                // Ogranicz ilość pytań do 5
                let limitedQuestions = Array(allQuestions.prefix(5))

                self.questions = limitedQuestions
            }
        }
    }

    func loadUserQuestion(_ set: String) {
        let userId = Auth.auth().currentUser?.uid
        
        db.collection(set)
            .whereField("userId", isEqualTo: userId as Any)
            .getDocuments { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.userQuestions = querySnapshot.documents.compactMap { document in
                        do {
                            var question = try document.data(as: Question.self)
                            question.id = document.documentID
                            return question
                        } catch {
                            print("Error loading data: \(error)")
                            return nil
                        }
                    }
                }
            }
    }


    
    func addQuestion(set: String, question: String, answer: String, level: String, a: String, b:String, c: String, d: String) {
        if let userId = user?.uid {
            db.collection(set).addDocument(data: [
                "question": question,
                "answer": answer,
                "level": level,
                "a": a,
                "b": b,
                "c": c,
                "d": d,
                "userId": userId
            ]) { error in
                if let error = error {
                    print("Error saving question: \(error)")
                }
            }
        }
        self.loadUserQuestion(set)
    }

    func deleteQuestion(_ question: Question, set: String) {
        if let questionID = question.id {
            db.collection(set).document(questionID).delete { error in
                if let error = error {
                    print("Error deleting question: \(error)")
                } else {
                    print("Question deleted successfully")
                    self.loadUserQuestion(set)
                }
            }
        }
    }
}
