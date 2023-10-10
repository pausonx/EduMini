//
//  FlashcardViewModel.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 10/10/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class FlashcardViewModel: ObservableObject {
    @Published var flashcards = [Flashcard]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    init() {
        loadFlashcardData()
    }
    
    func loadFlashcardData() {
        let userId = Auth.auth().currentUser?.uid
        
        db.collection("flashcards")
            .whereField("userId", isEqualTo: userId as Any)
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.flashcards = querySnapshot.documents.compactMap { document in
                    do {
                        let x = try document.data(as: Flashcard.self)
                        return x
                    }
                    catch {
                        print(error)
                    }
                    return nil
                }
            }
        }
    }
    
    func addFlashcard(topic: String, question: String, answer: String, fliping: Bool) {
        if let userId = user?.uid {
            db.collection("flashcards").addDocument(data: [
                "topic": topic,
                "question": question,
                "answer": answer,
                "fliping": fliping,
                "userId": userId
            ]) { error in
                if let error = error {
                    print("Error saving flashcard: \(error)")
                }
            }
        }
        self.loadFlashcardData()
    }
    
    func deleteFlashcard(at indexSet:IndexSet) {
        let docId = indexSet.map{
            self.flashcards[$0].id
        }
        for documentID in docId {
            db.collection("flashcards").document(documentID!).delete() { error in
                if let error = error {
                            print("Error deleting flashcard: \(error)")
                }
            }
        }
    }
    
    func toggleFlipingValue(docId documentID: String, newValue: Bool){
        db.collection("flashcards").document(documentID).updateData(["fliping": newValue]) { error in
            if let error = error {
                print("Error updating flashcard: \(error)")
            }
        }
    }
    
    func toggleFlipping(for flashcard: Flashcard){
        guard let index = self.flashcards.firstIndex(where: {$0.id == flashcard.id}) else { return }
        self.flashcards[index].fliping.toggle()
        toggleFlipingValue(docId: flashcard.id!, newValue: self.flashcards[index].fliping)
    }
    
    func updateCard(flashcard: Flashcard, newTopic: String, newQuestion: String, newAnswer: String) {
        guard let index = self.flashcards.firstIndex(where: {$0.id == flashcard.id}) else { return }
        self.flashcards[index].topic = newTopic
        self.flashcards[index].question = newQuestion
        self.flashcards[index].answer = newAnswer
        
        db.collection("flashcards").document(flashcard.id!).updateData([
            "topic": newTopic,
            "question": newQuestion,
            "answer": newAnswer
        ]) { error in
            if let error = error {
                print("Error updating flashcard document: \(error)")
            }
        }
    }
}

