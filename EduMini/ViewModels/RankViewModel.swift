//
//  RankViewModel.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 14/11/2023.
//

import Foundation

class RankViewModel: ObservableObject {
    @Published var users = [AppUser]()
    @Published var loggedInUserID: String?
    @Published var loggedInUserPoints: String?

    func fetchAndSortUsers() {
        FirebaseManager.shared.firestore.collection("users")
            .getDocuments { documentsSnapshot, error in
                if let error = error {
                    print("Failed to fetch users: \(error)")
                    return
                }

                var fetchedUsers = [AppUser]()

                documentsSnapshot?.documents.forEach { snapshot in
                    let data = snapshot.data()
                    let user = AppUser(data: data)

                    if user.uid == FirebaseManager.shared.auth.currentUser?.uid {
                        self.loggedInUserPoints = user.points
                    }

                    fetchedUsers.append(user)
                }

                self.sortAndAddCurrentUser(users: fetchedUsers)
            }
    }

    private func sortAndAddCurrentUser(users: [AppUser]) {
        // Sortuj użytkowników po ilości punktów w kolejności malejącej
        let sortedUsers = users.sorted { Int($0.points) ?? 0 > Int($1.points) ?? 0 }

        // Sprawdź, czy zalogowany użytkownik jest już na liście
        if sortedUsers.firstIndex(where: { $0.uid == FirebaseManager.shared.currentUser?.uid }) != nil {
            self.users = sortedUsers
            self.loggedInUserID = FirebaseManager.shared.currentUser?.uid
            // Zalogowany użytkownik jest już na liście, więc nie dodawaj go ponownie
        } else if let currentUser = FirebaseManager.shared.currentUser {
            self.users = sortedUsers + [currentUser]
            self.loggedInUserID = currentUser.uid
        } else {
            self.users = sortedUsers
        }
    }

    func place(for userID: String) -> String {
        if let index = users.firstIndex(where: { $0.uid == userID }) {
            return "\(index + 1)."
        } else {
            return ""
        }
    }
}

