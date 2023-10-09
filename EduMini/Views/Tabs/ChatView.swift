//
//  ChatView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 13/08/2023.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject private var UserProfileVM = UserProfileViewModel()
    @State private var lastRefreshDate = Date()
    @EnvironmentObject var settings: ParentalControlSettings
    
    
    func stringToAge(_ ageString: String) -> Int {
        return Int(ageString) ?? 0
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("hellopagebg") // Ustawienie obrazu jako tło
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                    .background(Color.clear)
                
                let age = UserProfileVM.appUser?.age ?? ""
                
                let ageInt = stringToAge(age)
                if ageInt > 6 {
                    VStack{
                        MainMessageView()
                    }
                } else {
                    VStack{
                        Text("Dostęp do czatu został ograniczony ze względu na wiek użytkownika!")
                            .font(.system(size: 20, weight: .light))
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.2)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(25)
                            .padding(.bottom, UIScreen.main.bounds.height * 0.2)
                    }
                }
            }
        }
        .tabItem {
            Label("Chat", systemImage: "message.fill")
        }
        .onAppear {
            // Rozpocznij timer przy pojawieniu się widoku
            startRefreshTimer()
        }
        .onDisappear {
            // Zatrzymaj timer przy zniknięciu widoku
            stopRefreshTimer()
        }
    }
    // Metoda rozpoczynająca timer odświeżania
    private func startRefreshTimer() {
        UserProfileVM.fetchCurrentUser(settings: settings)
        UserProfileVM.fetchAllUsers()
        Timer.scheduledTimer(withTimeInterval: 120.0, repeats: true) { _ in
            UserProfileVM.fetchCurrentUser(settings: settings)
            UserProfileVM.fetchAllUsers()
        }
    }
    
    // Metoda zatrzymująca timer odświeżania
    private func stopRefreshTimer() {
        UserProfileVM.errorMessage = "" // Wyczyść ewentualne błędy
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
