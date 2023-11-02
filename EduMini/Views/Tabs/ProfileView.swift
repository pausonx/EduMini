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
    @ObservedObject private var UserProfileVM = UserProfileViewModel()
    
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Background(title: "profileBG")

                    VStack(spacing: 12) {
                        ProfileTitle()
                        ProfileInfo()
                        
                        Divider()
                            .padding(.horizontal, 15)
                        
                        NavigationLink(destination: PINCheck().environmentObject(settings)) {
                            HStack {
                                Text("Kontrola rodzicielska")
                                    .font(.system(size: 20, weight: .light))
                                    .foregroundColor(Color("DarkGrayColor"))

                                Image(systemName: "shield.fill")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(Color("DarkGrayColor"))

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
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
    }
}

struct ProfileTitle: View {
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject private var UserProfileVM = UserProfileViewModel()
    
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: UIScreen.main.bounds.width * 0.35, weight: .light))
                .foregroundColor(Color("DarkGrayColor").opacity(0.8).opacity(0.9))
            
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.top, -20)
    }
}

struct ProfileInfo: View {
    @ObservedObject private var UserProfileVM = UserProfileViewModel()
    @EnvironmentObject var settings: ParentalControlSettings
    
    func stringToAge(_ ageString: String) -> Int {
        // Używamy Int.init(_:), który zwraca opcjonalną liczbę (Int?)
        // Jeśli konwersja nie powiedzie się, zostanie zwrócone nil
        return Int(ageString) ?? 0
    }
    
    var body: some View {
        let name = UserProfileVM.appUser?.name ?? "Test"
        let nick = UserProfileVM.appUser?.nick ?? "Test"
        
        Text(name)
            .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.1))
            .multilineTextAlignment(.leading)
            .padding(5)
            .foregroundColor(Color.white)
        
        Text(nick)
            .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.06))
            .multilineTextAlignment(.leading)
            .padding(5)
            .foregroundColor(Color.white)
        
        Divider()
            .padding(.horizontal, 15)
        
        HStack {
            let age = UserProfileVM.appUser?.age ?? ""

            VStack {
                let ageVisible = UserProfileVM.appUser?.ageVisible ?? ""
                
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
                    .foregroundColor(Color("DarkGrayColor"))

            }
            .padding(20)
            .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.1)
            .background(Color.white.opacity(0.2))
            .cornerRadius(25)

                        
            VStack {
                let points = UserProfileVM.appUser?.points ?? ""
                Text(points)
                    .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.07))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.white)
                
                Text("Punkty")
                    .font(.system(size: 17, weight: .light))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color("DarkGrayColor"))
            }
            .padding(20)
            .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.1)
            .background(Color.white.opacity(0.2))
            .cornerRadius(25)


            VStack {
                let ageInt = stringToAge(age)
                if ageInt > 6 {
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
                    .foregroundColor(Color("DarkGrayColor"))

            }
            .padding(20)
            .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.1)
            .background(Color.white.opacity(0.3))
            .cornerRadius(25)

        }
        
        Divider()
            .padding(.horizontal, 15)
        
        HStack {
            let email = UserProfileVM.appUser?.email ?? ""
            let emailVisible = UserProfileVM.appUser?.emailVisible ?? ""
            
            Spacer()
            
            if emailVisible == "yes" {
                Text(email)
                    .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.05))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.white)
            } else {
                Text("Adres email jest ukryty")
                    .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.05))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.white)
            }
                       
            Spacer()
        }
        .padding(.bottom, 10)

    }
}
