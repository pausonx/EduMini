//
//  ParentalControl.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 23/08/2023.
//

import SwiftUI

class ParentalControlSettings: ObservableObject {
    @Published var isActiveChat: Bool
    @Published var isActiveEmail: Bool
    @Published var isActiveAge: Bool
    
    init(isActiveChat: Bool, isActiveEmail: Bool, isActiveAge: Bool) {
        self.isActiveChat = isActiveChat
        self.isActiveEmail = isActiveEmail
        self.isActiveAge = isActiveAge
    }
}

struct ParentalControl: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var settings: ParentalControlSettings = ParentalControlSettings(
        isActiveChat: false,
        isActiveEmail: false,
        isActiveAge: false
    )
    @ObservedObject private var NUViewModel = NewAppUsersModel()
    
    init() {
        let initialSettings = ParentalControlSettings(
            isActiveChat: false,
            isActiveEmail: false,
            isActiveAge: false
        )
        _settings = StateObject(wrappedValue: initialSettings)
        
        if let appUser = NUViewModel.appUser {
            NUViewModel.fetchCurrentUser(settings: settings) // Przekazanie settings
            settings.isActiveChat = appUser.chat == "yes"
            settings.isActiveEmail = appUser.emailVisible == "yes"
            settings.isActiveAge = appUser.ageVisible == "yes"
        }
    }
    
    var body: some View {
        ZStack {
            
            List {
                Toggle("Zezwól na chat z innymi użytkownikami", isOn: $settings.isActiveChat)
                    .onChange(of: settings.isActiveChat) { newValue in
                        NUViewModel.saveParentalControlSettings(settings)
                    }
                    .foregroundColor(Color.black.opacity(0.8))
                    .font(.system(size: 16, weight: .light))
                    .padding(8)

                
                Toggle("Ukryj adres email na profilu", isOn: $settings.isActiveEmail)
                    .onChange(of: settings.isActiveEmail) { newValue in
                        NUViewModel.saveParentalControlSettings(settings)
                    }
                    .foregroundColor(Color.black.opacity(0.8))
                    .font(.system(size: 16, weight: .light))
                    .padding(8)

                
                Toggle("Ukryj wiek dziecka na profilu", isOn: $settings.isActiveAge)
                    .onChange(of: settings.isActiveAge) { newValue in
                        NUViewModel.saveParentalControlSettings(settings)
                    }
                    .foregroundColor(Color.black.opacity(0.8))
                    .font(.system(size: 16, weight: .light))
                    .padding(8)
                
            }
            
        }
        .navigationBarTitle("Kontrola rodzicielska")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrowshape.turn.up.left.fill")
                        .foregroundColor(.white)
                }
            }
        }
        .modifier(NavigationBarColorModifier(backgroundColor: UIColor(Color.accentColor), tintColor: UIColor.white))
    }
}

struct ParentalControl_Previews: PreviewProvider {
    static var previews: some View {
        ParentalControl()
    }
}
