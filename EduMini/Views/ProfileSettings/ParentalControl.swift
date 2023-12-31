//
//  ParentalControl.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 23/08/2023.
//

import SwiftUI

class ParentalControlSettings: ObservableObject {
    @Published var isActiveEmail: Bool
    @Published var isActiveAge: Bool
    
    init(isActiveEmail: Bool, isActiveAge: Bool) {
        self.isActiveEmail = isActiveEmail
        self.isActiveAge = isActiveAge
    }
}


struct ParentalControl: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var UserProfileVM = UserProfileViewModel()
    @ObservedObject var ParentalControlVM = ParentalControlViewModel()
    
    @State private var isEmailActive: Bool = true
    @State private var isAgeActive: Bool = true
    
    @State private var onOffEmail: String = ""
    @State private var onOffAge: String = ""
    
    init() {
        
        // Pobierz wartość 'emailVisible' z UserProfileVM i ustaw odpowiednią zmienną
        let emailVisible = UserProfileVM.appUser?.emailVisible ?? ""
        onOffEmail = emailVisible == "yes" ? " widoczny" : " ukryty"
        isEmailActive = emailVisible == "yes"
        
        // Pobierz wartość 'ageVisible' z UserProfileVM i ustaw odpowiednią zmienną
        let ageVisible = UserProfileVM.appUser?.ageVisible ?? ""
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
                        .background(isEmailActive ? Color("BabyBlueColor").opacity(0.9) : Color("BabyBlueColor").opacity(0.5))
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
                        .background(isAgeActive ? Color("BabyBlueColor").opacity(0.9) : Color("BabyBlueColor").opacity(0.5))
                        .cornerRadius(8)
                    }
                    
                    Text("Chat jest niedostępny dla dzieci poniżej 7 r.ż.!")
                        .font(.system(size: 15, weight: .light))
                        .padding(2)
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
                                .onChange(of: name) { oldValue, newValue in
                                    self.name = newValue
                                }
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
                                            .fill(isValidName ? Color("BabyBlueColor").opacity(0.9) : (isSaveNameButtonClicked ? Color.gray : Color("BabyBlueColor").opacity(0.9)))
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
                                .onChange(of: age) { oldValue, newValue in
                                    self.age = newValue
                                }
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
                                            .fill(isValidAge ? Color("BabyBlueColor").opacity(0.9) : (isSaveAgeButtonClicked ? Color.gray : Color("BabyBlueColor").opacity(0.9)))
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

                }
                .listStyle(SidebarListStyle())
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let emailVisible = UserProfileVM.appUser?.emailVisible ?? ""
                onOffEmail = emailVisible == "yes" ? " widoczny" : " ukryty"
                
                let ageVisible = UserProfileVM.appUser?.ageVisible ?? ""
                onOffAge = ageVisible == "yes" ? " widoczny" : " ukryty"
                
            }
        }
    }
    
    private func saveEmailSetting() {
        ParentalControlVM.saveEmailSetting(isEmailActive)
    }
    
    private func saveAgeSetting() {
        ParentalControlVM.saveAgeSetting(isAgeActive)
    }
    
    private func updateName() {
        ParentalControlVM.updateName(name)
    }
    
    private func updateAge() {
        ParentalControlVM.updateAge(age)
    }
}

struct ParentalControl_Previews: PreviewProvider {
    static var previews: some View {
        ParentalControl()
    }
}
