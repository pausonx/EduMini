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
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Color.accentColor
                    
                    Image("bg") // Ustawienie obrazu jako tło
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .ignoresSafeArea()
                    
                    ZStack {
                        Color.white.opacity(0.7)
                            .cornerRadius(15)
                        
                        
                        VStack(spacing: 12) {
                            ProfileTitle()
                            
                            ProfileInfo()
                            
                            Divider()
                            
                            
                            NavigationLink(destination: PINCheck()) {
                                Text("Kontrola rodzicielska")
                                    .font(.system(size: 25, weight: .light))
                                Image(systemName: "shield.fill")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(Color.accentColor)
                                //Po kliknięciu trzeba sprawdzić PIN poprzez jakiś input i wtedy przejdzie do widoku gdzie te suwaki pokazać z możliwością wprowadzenia zmian
                            }
                            
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
            .navigationBarTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
        .tabItem {
            Label("Profil", systemImage: "person.fill")
        }
    }
}

struct ProfileTitle: View {
    var body: some View {
        Text("Twój profil")
            .font(.system(size: 40, weight: .light))
            .multilineTextAlignment(.leading)
            
        Divider()
            
        Image(systemName: "person.crop.circle.fill")
            .font(.system(size: 150, weight: .light))
            .foregroundColor(Color.accentColor)
    }
}

struct ProfileInfo: View {
    @ObservedObject private var NUViewModel = NewAppUsersModel()

    var body: some View {
        HStack {
            let name = NUViewModel.appUser?.name ?? ""
            
            Text(name)
                .font(.system(size: 35, weight: .light))
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Image(systemName: "pencil")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(Color.accentColor)
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
            
            Image(systemName: "pencil")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(Color.accentColor)
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
            
            Image(systemName: "pencil")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(Color.accentColor)
            
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
