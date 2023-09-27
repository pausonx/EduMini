//
//  GameViewModel.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 27/09/2023.
//

import Firebase

class GameViewModel: ObservableObject {
    
    @Published var appUser: AppUser?
    @Published var users = [AppUser]()
    @Published var errorMessage = ""
    
    private let firebaseRepository = FirebaseRepository.shared
    
    ///Do sprawdzenia funkcja dodająca punkty po zakończeniu gry na danym poziomie, pobieramy aktualną ilość punktów i ilość odpowiednią do dodania - sprawdzić czy dobrze działa, nie ma na razie funkcji dodającej punkty bezpośrednio w widoku takiej jak aktualizacja danych w parentalControl - umieścić w części głównej opowiedzialnej za działanie gry
    func updatePoints(_ points: String, amountToAdd: Int) {
        guard let currentPoints = Int(points) else {
            // Jeśli nie można przekonwertować punktów na liczbę całkowitą, przerwij funkcję
            return
        }
        
        let newPoints = currentPoints + amountToAdd
        let newPointsString = String(newPoints)
        
        firebaseRepository.updateUserData("points", dataValue: newPointsString) { error in
            if let error = error {
                self.errorMessage = "Error updating points: \(error)"
                print("Error updating points: \(error)")
            } else {
                print("Points updated successfully!")
            }
        }
    }
    
}
