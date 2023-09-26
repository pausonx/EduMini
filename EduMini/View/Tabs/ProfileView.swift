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
                    Image("profileBG")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .edgesIgnoringSafeArea(.all)
                        .background(Color.clear)

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
                            .padding(.horizontal, 15)
                        
                        NavigationLink(destination: PINCheck().environmentObject(settings)) {
                            HStack {
                                Text("Kontrola rodzicielska")
                                    .font(.system(size: 20, weight: .light))
                                    .foregroundColor(Color.secondary)

                                Image(systemName: "shield.fill")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(Color.secondary)

                                Spacer()
                            }
                            .padding(10)
                            .navigationBarBackButtonHidden(true)

                        }
                        
                        Spacer()
                    }
                    .padding()
                }
            }
        }
        .tabItem {
            Label("Profil", systemImage: "person.fill")
        }
    }
    
    // Metoda rozpoczynająca timer odświeżania
    private func startRefreshTimer() {
        NUViewModel.fetchCurrentUser(settings: settings)
        NUViewModel.fetchAllUsers()
        Timer.scheduledTimer(withTimeInterval: 120.0, repeats: true) { _ in
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
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject private var NUViewModel = NewAppUsersModel()
    
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: UIScreen.main.bounds.width * 0.35, weight: .light))
                .foregroundColor(Color.secondary.opacity(0.9))
            
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.top, -20)
    }
}

struct ProfileInfo: View {
    @ObservedObject private var NUViewModel = NewAppUsersModel()
    @EnvironmentObject var settings: ParentalControlSettings
    
    var body: some View {
        let name = NUViewModel.appUser?.name ?? "Test"
        
        Text(name)
            .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.1))
            .multilineTextAlignment(.leading)
            .padding(5)
            .foregroundColor(Color.white)
        
        HStack {
            let email = NUViewModel.appUser?.email ?? ""
            let emailVisible = NUViewModel.appUser?.emailVisible ?? ""
            
            Spacer()
            
            if emailVisible == "yes" {
                Text(email)
                    .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.06))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.white)
            } else {
                Text("Adres email jest ukryty")
                    .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.06))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.white)
            }
                       
            Spacer()
        }
        .padding(.bottom, 10)
        
        Divider()
            .padding(.horizontal, 15)
        
        HStack {
            VStack {
                let age = NUViewModel.appUser?.age ?? ""
                let ageVisible = NUViewModel.appUser?.ageVisible ?? ""
                
                if ageVisible == "yes" {
                    Text(age)
                        .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.05))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.white)
                } else {
                    Text("ukryty")
                        .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.06))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.white)

                }
                
                Text("Wiek")
                    .font(.system(size: 17, weight: .light))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.secondary)

            }
            .padding(20)
            .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.1)
            .background(Color.white.opacity(0.2))
            .cornerRadius(25)

                        
            VStack {
                let points = NUViewModel.appUser?.points ?? ""
                Text(points)
                    .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.07))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.white)
                
                Text("Punkty")
                    .font(.system(size: 17, weight: .light))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.secondary)
            }
            .padding(20)
            .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.1)
            .background(Color.white.opacity(0.2))
            .cornerRadius(25)


            VStack {
                let chat = NUViewModel.appUser?.chat ?? ""
                
                if chat == "yes" {
                    Text("włączony")
                        .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.04))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.green)
                } else {
                    Text("wyłączony")
                        .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.04))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.red)
                    
                }
                
                Text("Chat")
                    .font(.system(size: 17, weight: .light))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.secondary)

            }
            .padding(20)
            .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.1)
            .background(Color.white.opacity(0.3))
            .cornerRadius(25)
        

        }
    }
}


//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
