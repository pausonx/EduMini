//
//  ProfileView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 08/08/2023.
//

import SwiftUI

struct ProfileView: View {
    @State var shouldShowLogOutOptions = false
    
    @EnvironmentObject var viewModel: AppViewModel
    @EnvironmentObject var settings: ParentalControlSettings
    @ObservedObject private var NUViewModel = NewAppUsersModel()
    

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Color("LightGrayColor")

                    ZStack {
                        Color.white
                            .cornerRadius(15)

                        VStack(spacing: 12) {
                            ProfileTitle()

                            ProfileInfo()
                                .onAppear {
                                    // Rozpocznij timer przy pojawieniu się widoku
                                    startRefreshTimer()
                                }
                                .onDisappear {
                                    // Zatrzymaj timer przy zniknięciu widoku
                                    stopRefreshTimer()
                                }

                            Divider()

                            NavigationLink(destination: PINCheck().environmentObject(settings)) {
                                Text("Kontrola rodzicielska")
                                    .font(.system(size: 25, weight: .light))
                                Image(systemName: "shield.fill")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(Color.accentColor)
                            }
                            .navigationBarBackButtonHidden()

                            Divider()

                            HStack {
                                Text("Wyloguj się")
                                    .font(.system(size: 20, weight: .light))

                                Button {
                                    shouldShowLogOutOptions.toggle()
                                } label: {
                                    Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                                        .font(.system(size: 25, weight: .bold))
                                        .foregroundColor(Color.accentColor)
                                }

                                Spacer()
                            }

                            Spacer()
                        }
                        .padding()
                        .actionSheet(isPresented: $shouldShowLogOutOptions) {
                            .init(title: Text("Wylogowywanie"), message: Text("Czy na pewno chcesz to zrobić?"), buttons: [
                                .destructive(Text("Wyloguj się"), action: {
                                    viewModel.signOut()
                                }),
                                .cancel(Text("Anuluj"))
                            ])
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Twój profil")
            .navigationBarTitleDisplayMode(.inline)
            .modifier(NavigationBarColorModifier(backgroundColor: UIColor(Color.accentColor), tintColor: UIColor.white))
        }
        .tabItem {
            Label("Profil", systemImage: "person.fill")
        }
    }

    // Metoda rozpoczynająca timer odświeżania
    private func startRefreshTimer() {
        NUViewModel.fetchCurrentUser(settings: settings)
        NUViewModel.fetchAllUsers()
        Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
            NUViewModel.fetchCurrentUser(settings: settings)
            NUViewModel.fetchAllUsers()
        }
    }

    // Metoda zatrzymująca timer odświeżania
    private func stopRefreshTimer() {
        NUViewModel.errorMessage = "" // Wyczyść ewentualne błędy
    }
}

struct ProfileTitle: View {
    var body: some View {
        Image(systemName: "person.crop.circle.fill")
            .font(.system(size: 150, weight: .light))
            .foregroundColor(Color.accentColor)
    }
}

struct ProfileInfo: View {
    @ObservedObject private var NUViewModel = NewAppUsersModel()
    @EnvironmentObject var settings: ParentalControlSettings

    var body: some View {
        HStack {
            let name = NUViewModel.appUser?.name ?? ""
            
            Text(name)
                .font(.system(size: 35, weight: .light))
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        
        HStack {
            let age = NUViewModel.appUser?.age ?? ""
            let ageVisible = NUViewModel.appUser?.ageVisible ?? ""
            
            Text("Wiek: ")
                .font(.system(size: 20, weight: .light))
                .multilineTextAlignment(.leading)
            
            if ageVisible == "yes" {
                Text(age)
                    .font(.system(size: 20, weight: .light))
                    .multilineTextAlignment(.leading)
            } else {
                Text("ukryty")
                    .font(.system(size: 20, weight: .light))
                    .italic()
                    .multilineTextAlignment(.leading)
            }
            Spacer()
        }
        
        
        HStack {
            let email = NUViewModel.appUser?.email ?? ""
            let emailVisible = NUViewModel.appUser?.emailVisible ?? ""
            
            Text("Adres email: ")
                .font(.system(size: 20, weight: .light))
                .multilineTextAlignment(.leading)
            
            if emailVisible == "yes" {
                Text(email)
                    .font(.system(size: 20, weight: .light))
                    .multilineTextAlignment(.leading)
            } else {
                Text("ukryty")
                    .font(.system(size: 20, weight: .light))
                    .italic()
                    .multilineTextAlignment(.leading)
            }
            Spacer()
        }
        
        HStack {
            let chat = NUViewModel.appUser?.chat ?? ""
            
            Text("Chat: ")
                .font(.system(size: 20, weight: .light))
                .multilineTextAlignment(.leading)
            
            if chat == "yes" {
                Text("włączony")
                    .font(.system(size: 20, weight: .light))
                    .italic()
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.green)
            } else {
                Text("wyłączony")
                    .font(.system(size: 20, weight: .light))
                    .italic()
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.red)

            }
            Spacer()
        }
    }
}
