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
        
    @State private var onOffChat: String = ""
    @State private var onOffEmail: String = ""
    @State private var onOffAge: String = ""

    init() {
        // Pobierz wartość 'chat' z NUViewModel i ustaw odpowiednią zmienną
        let chat = NUViewModel.appUser?.chat ?? ""
        onOffChat = chat == "yes" ? " włączony" : " wyłączony"
        isChatActive = chat == "yes"
        
        // Pobierz wartość 'emailVisible' z NUViewModel i ustaw odpowiednią zmienną
        let emailVisible = NUViewModel.appUser?.emailVisible ?? ""
        onOffEmail = emailVisible == "yes" ? " widoczny" : " ukryty"
        isEmailActive = emailVisible == "yes"
        
        // Pobierz wartość 'ageVisible' z NUViewModel i ustaw odpowiednią zmienną
        let ageVisible = NUViewModel.appUser?.ageVisible ?? ""
        onOffAge = ageVisible == "yes" ? " widoczny" : " ukryty"
        isAgeActive = ageVisible == "yes"
    }
    
    @State private var isValidName: Bool = false
    @State private var isValidAge: Bool = false
    @State private var nameHint: String = ""
    @State private var ageHint: String = ""
    
    @State private var name: String = "" {
        didSet {
            isValidName = name.isValid(regexes: [Regex.name].compactMap { "\($0.rawValue)" })
            nameHint = isValidName ? "" : "Imię musi składać się tylko z liter"
        }
    }
    
    @State private var age: String = "" {
        didSet {
            isValidAge = age.isValid(regexes: [Regex.age].compactMap { "\($0.rawValue)" })
            ageHint = isValidAge ? "" : Hint.age.rawValue
        }
    }
    
    @State private var showHelpName = false
    @State private var showHelpAge = false

    @State private var isSaveNameButtonClicked = false
    @State private var isSaveAgeButtonClicked = false
    
    @State private var isSavedName: Bool = false
    @State private var isSavedAge: Bool = false
    
    var body: some View {
        ZStack {
            List {
                Section(header: Text("Ustawienia").font(.system(size: 18))){
                    HStack {
                        Text("Chat z innymi użytkownikami")
                            .font(.system(size: 15, weight: .light)) +
                            Text(onOffChat)
                            .italic()
                            .font(.system(size: 15, weight: .semibold))

                        Spacer()
                        
                        Button(action: {
                            isChatActive.toggle()
                            saveChatSetting()
                            if isChatActive {
                                onOffChat = " włączony"
                            }
                            else {
                                onOffChat = " wyłączony"
                            }
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
                        Text("Adres email na profilu")
                            .font(.system(size: 15, weight: .light)) +
                            Text(onOffEmail)
                            .italic()
                            .font(.system(size: 15, weight: .semibold))
                        
                        Spacer()
                        
                        Button(action: {
                            isEmailActive.toggle()
                            saveEmailSetting()
                            if isEmailActive {
                                onOffEmail = " widoczny"
                            }
                            else {
                                onOffEmail = " ukryty"
                            }
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
                        Text("Wiek dziecka na profilu")
                            .font(.system(size: 15, weight: .light)) +
                            Text(onOffAge)
                            .italic()
                            .font(.system(size: 15, weight: .semibold))
                        
                        Spacer()
                        
                        Button(action: {
                            isAgeActive.toggle()
                            saveAgeSetting()
                            if isAgeActive {
                                onOffAge = " widoczny"
                            }
                            else {
                                onOffAge = " ukryty"
                            }
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
                    VStack{
                        HStack {
                            Text("Zmiana imienia")
                                .font(.system(size: 16, weight: .light))
                            
                            Spacer()
                        }
                        HStack {
                            TextField("Podaj nowe imie", text: $name)
                                .onChange(of: name, perform: { newValue in
                                    self.name = newValue
                                })
                                .font(.system(size: 15, weight: .light))
                            
                            Button(action: {
                                updateName()
                                isSaveNameButtonClicked = true
                                isSavedName = true
                            }) {
                                Text("Zapisz")
                                    .foregroundColor(Color.black.opacity(0.8))
                                    .font(.system(size: 15, weight: .light))
                                    .padding(11)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(isValidName ? Color.accentColor.opacity(0.9) : (isSaveNameButtonClicked ? Color.gray : Color.accentColor.opacity(0.9)))
                                    )
                            }
                            .disabled(isSaveNameButtonClicked || !isValidName)
                        }
                        HStack {
                            TextFieldHintRed(hint: nameHint)
                            Spacer()
                            if isSavedName {
                                Text("Zapisano")
                                    .foregroundColor(Color.green)
                                    .font(.system(size: 15, weight: .light))
                                    .italic()
                            }
                        }
                    }
                
                    VStack {
                        HStack {
                            Text("Zmiana wieku")
                                .font(.system(size: 16, weight: .light))
                            Spacer()
                        }
                        HStack {
                            TextField("Podaj nowy wiek", text: $age)
                                .onChange(of: age, perform: { newValue in
                                    self.age = newValue
                                })
                                .font(.system(size: 15, weight: .light))
                            
                            Button(action: {
                                updateAge()
                                isSaveAgeButtonClicked = true
                                isSavedAge = true
                            }) {
                                Text("Zapisz")
                                    .foregroundColor(Color.black.opacity(0.8))
                                    .font(.system(size: 15, weight: .light))
                                    .padding(11)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(isValidAge ? Color.accentColor.opacity(0.9) : (isSaveAgeButtonClicked ? Color.gray : Color.accentColor.opacity(0.9)))
                                    )
                            }
                            .disabled(isSaveAgeButtonClicked || !isValidAge)
                            
                            
                        }
                        HStack {
                            TextFieldHintRed(hint: ageHint)
                            Spacer()
                            if isSavedAge {
                                Text("Zapisano")
                                    .foregroundColor(Color.green)
                                    .font(.system(size: 15, weight: .light))
                                    .italic()
                            }
                        }
                    }

//                    VStack {
/// Możliwe do dorobienia zmiana adresu email, ale do rostrzygnięcia czy nie narobi problemów z logowaniem itd.
//                    }
                }
                .listStyle(SidebarListStyle())
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let chat = NUViewModel.appUser?.chat ?? ""
                onOffChat = chat == "yes" ? " włączony" : " wyłączony"
                
                let emailVisible = NUViewModel.appUser?.emailVisible ?? ""
                onOffEmail = emailVisible == "yes" ? " widoczny" : " ukryty"

                let ageVisible = NUViewModel.appUser?.ageVisible ?? ""
                onOffAge = ageVisible == "yes" ? " widoczny" : " ukryty"

            }
        }
    }
    
    private func saveChatSetting() {
        NUViewModel.saveChatSetting(isChatActive)
    }
    
    private func saveEmailSetting() {
        NUViewModel.saveEmailSetting(isEmailActive)
    }
    
    private func saveAgeSetting() {
        NUViewModel.saveAgeSetting(isAgeActive)
    }
    
    private func updateName() {
        NUViewModel.updateName(name)
    }
    
    private func updateAge() {
        NUViewModel.updateAge(age)
    }
}

struct ParentalControl_Previews: PreviewProvider {
    static var previews: some View {
        ParentalControl()
    }
}
