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
    @ObservedObject var NUViewModel = NewAppUsersModel()
    
    @State private var isChatActive: Bool = true
    @State private var isEmailActive: Bool = true
    @State private var isAgeActive: Bool = true
    
    @State private var shouldRefreshView = false
    
    init() {
        // Pobierz wartość 'chat' z NUViewModel i ustaw odpowiednią zmienną
        let chat = NUViewModel.appUser?.chat ?? ""
        isChatActive = chat == "yes"
        
        // Pobierz wartość 'emailVisible' z NUViewModel i ustaw odpowiednią zmienną
        let emailVisible = NUViewModel.appUser?.emailVisible ?? ""
        isEmailActive = emailVisible == "yes"
        
        // Pobierz wartość 'ageVisible' z NUViewModel i ustaw odpowiednią zmienną
        let ageVisible = NUViewModel.appUser?.ageVisible ?? ""
        isAgeActive = ageVisible == "yes"
    }
    
    
    @State private var imie: String = ""
    
    var body: some View {
        ZStack {
            List {
                Section(header: Text("Ustawienia").font(.system(size: 18))){
                    HStack {
                        let chat = NUViewModel.appUser?.chat ?? ""
                        
                        if chat == "yes" {
                            Text("Chat z innymi użytkownikami")
                                .font(.system(size: 15, weight: .light)) +
                                Text(" włączony")
                                .italic()
                                .font(.system(size: 15, weight: .semibold))
                        } else {
                            Text("Chat z innymi użytkownikami")
                                .font(.system(size: 15, weight: .light)) +
                                Text(" wyłączony")
                                .italic()
                                .font(.system(size: 15, weight: .semibold))
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            isChatActive.toggle()
                            saveChatSetting()
                        }) {
                            Text("Zmień")
                        }
                        .foregroundColor(Color.black.opacity(0.8))
                        .font(.system(size: 15, weight: .light))
                        .padding(11)
                        .background(isChatActive ? Color.accentColor.opacity(0.9) : Color.accentColor.opacity(0.5))
                        .cornerRadius(8)
                        
                        
                    }
                    
                    HStack {
                        let emailVisible = NUViewModel.appUser?.emailVisible ?? ""
                        
                        if emailVisible == "yes" {
                            Text("Adres email na profilu")
                                .font(.system(size: 15, weight: .light)) +
                                Text(" widoczny")
                                .italic()
                                .font(.system(size: 15, weight: .semibold))
                        } else {
                            Text("Adres email na profilu")
                                .font(.system(size: 15, weight: .light)) +
                                Text(" ukryty")
                                .italic()
                                .font(.system(size: 15, weight: .semibold))
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            isEmailActive.toggle()
                            saveEmailSetting()
                        }) {
                            Text("Zmień")
                        }
                        .foregroundColor(Color.black.opacity(0.8))
                        .font(.system(size: 15, weight: .light))
                        .padding(11)
                        .background(isEmailActive ? Color.accentColor.opacity(0.9) : Color.accentColor.opacity(0.5))
                        .cornerRadius(8)
                    }
                    
                    HStack {
                        let ageVisible = NUViewModel.appUser?.ageVisible ?? ""
                        
                        if ageVisible == "yes" {
                            Text("Wiek dziecka na profilu")
                                .font(.system(size: 15, weight: .light)) +
                                Text(" widoczny")
                                .italic()
                                .font(.system(size: 15, weight: .semibold))
                        } else {
                            Text("Wiek dziecka na profilu")
                                .font(.system(size: 15, weight: .light)) +
                                Text(" ukryty")
                                .italic()
                                .font(.system(size: 15, weight: .semibold))
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            isAgeActive.toggle()
                            saveAgeSetting()
                        }) {
                            Text("Zmień")
                        }
                        .foregroundColor(Color.black.opacity(0.8))
                        .font(.system(size: 15, weight: .light))
                        .padding(11)
                        .background(isAgeActive ? Color.accentColor.opacity(0.9) : Color.accentColor.opacity(0.5))
                        .cornerRadius(8)
                    }
                }
                Section(header: Text("Edycja danych").font(.system(size: 18))){
//                    VStack{
//                        Text("Zmiana imienia")
//                        HStack {
//                            TextField("Podaj nowe imie", text: $imie)
//                            Button(action: {}
//                            ){
//                                Text("Zapisz")
//                            }
//                        }
//                        Spacer()
//                    }
//
//                    VStack {
//
//                    }
//
//                    VStack {
//
//                    }
                }
                .listStyle(GroupedListStyle())
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
        .onAppear {
            if shouldRefreshView {
                NUViewModel.fetchCurrentUser(settings: nil) // Odśwież widok po zapisaniu ustawienia
                shouldRefreshView = false // Zresetuj flagę
            }
        }
        
    }
    
    private func saveChatSetting() {
        NUViewModel.saveChatSetting(isChatActive)
        shouldRefreshView = true
    }
    
    private func saveEmailSetting() {
        NUViewModel.saveEmailSetting(isEmailActive)
        shouldRefreshView = true
    }
    
    private func saveAgeSetting() {
        NUViewModel.saveAgeSetting(isAgeActive)
        shouldRefreshView = true
    }
}

struct ParentalControl_Previews: PreviewProvider {
    static var previews: some View {
        ParentalControl()
    }
}
