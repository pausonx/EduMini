//
//  RegisterView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 07/08/2023.
//

import SwiftUI
import FirebaseFirestore

struct RegisterView: View {
    
    @State private var isValidLogin: Bool = false
    @State private var isValidPassword: Bool = false
    @State private var isValidAge: Bool = false
    @State private var isValidPIN: Bool = false
    
    @State private var loginHint: String = ""
    @State private var passwordHint: String = ""
    @State private var ageHint: String = ""
    @State private var pinHint: String = ""
    

    @State private var login: String = "" {
        didSet {
            isValidLogin = login.isValid(regexes: [Regex.login, Regex.email].compactMap { "\($0.rawValue)" })
            loginHint = isValidLogin ? "" : Hint.email.rawValue
        }
    }

    @State private var password: String = "" {
        didSet {
            isValidPassword = password.isValid(regexes: [Regex.password].compactMap { "\($0.rawValue)" })
            passwordHint = isValidPassword ? "" : Hint.password.rawValue
        }
    }
    
    @State private var age: String = "" {
        didSet {
            isValidAge = age.isValid(regexes: [Regex.age].compactMap { "\($0.rawValue)" })
            ageHint = isValidAge ? "" : Hint.age.rawValue
        }
    }
    
    
    @State private var pin: String = "" {
        didSet {
            isValidPIN = pin.isValid(regexes: [Regex.pin].compactMap { "\($0.rawValue)" })
            pinHint = isValidPIN ? "" : Hint.pin.rawValue
        }
    }
    
    @State private var name: String = ""
    
    
    @State private var showHelpAge = false
    @State private var showHelpPIN = false
    @State private var showHelpEmail = false

    @EnvironmentObject var viewModel: AppViewModel

    @ObservedObject private var NUViewModel = NewAppUsersModel()

    var body: some View {
        ScrollView {
            
            VStack(spacing: 20) {
                Text("Rejestracja")
                    .font(.system(size: 50, weight: .thin))
                    .foregroundColor(Color.white)
                
                Spacer()
                
                //MARK: - Name
                VStack(alignment: .leading, spacing: 10) {
                    TextFieldName(name: "Imię")
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.9))
                            .frame(height: 45)
                            .shadow(radius: 2)
                        
                        TextField("", text: $name)
                            .onChange(of: name, perform: { newValue in
                                self.name = newValue
                            })
                            .font(.system(size: 20, weight: .thin))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .frame(height: 45)
                            .padding(.horizontal, 10)
                            .foregroundColor(.black.opacity(0.8))
                        
                    }
                }
                
                //MARK: - Email
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        TextFieldName(name: "Email")
                        Button(action: {
                            showHelpEmail = true // Pokaż instrukcję
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                showHelpEmail = false // Ukryj instrukcję po 3 sekundach
                            }
                        }) {
                            Image(systemName: "questionmark.circle")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(Color.white.opacity(0.7))
                        }
                    }
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.9))
                            .frame(height: 45)
                            .shadow(radius: 2)
                        
                        TextField("", text: $login)
                            .onChange(of: login, perform: { newValue in
                                self.login = newValue
                            })
                            .font(.system(size: 20, weight: .thin))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .frame(height: 45)
                            .padding(.horizontal, 10)
                            .foregroundColor(.black.opacity(0.8))
                        
                    }
                    
                    TextFieldHint(hint: loginHint)
                }
                .overlay(
                        Group {
                            if showHelpEmail {
                                Text("Widoczność adresu email można zmienić w ustawieniach w zakładce kontrola rodzicielska.")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.secondary)
                                    .cornerRadius(10)
                                    .transition(.opacity)
                            }
                        }
                    )
                
                //MARK: - Age
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        TextFieldName(name: "Wiek")
                        Button(action: {
                            showHelpAge = true // Pokaż instrukcję
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                showHelpAge = false // Ukryj instrukcję po 3 sekundach
                            }
                        }) {
                            Image(systemName: "questionmark.circle")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(Color.white.opacity(0.7))
                        }
                    }
                                    
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.9))
                            .frame(height: 45)
                            .shadow(radius: 2)
                        
                        TextField("", text: $age)
                            .onChange(of: age, perform: { newValue in
                                self.age = newValue
                            })
                            .font(.system(size: 20, weight: .thin))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .frame(height: 45)
                            .padding(.horizontal, 10)
                            .foregroundColor(.black.opacity(0.8))
                        
                    }
                    
                    TextFieldHint(hint: ageHint)
                }
                .overlay(
                        Group {
                            if showHelpAge {
                                Text("Wprowadź liczbę. Widoczność wieku można zmienić w ustawieniach w zakładce kontrola rodzicielska.")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.secondary)
                                    .cornerRadius(10)
                                    .transition(.opacity)
                            }
                        }
                    )
                
                
                //MARK: - PIN
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        TextFieldName(name: "PIN")
                        Button(action: {
                            showHelpPIN = true // Pokaż instrukcję
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                showHelpPIN = false // Ukryj instrukcję po 3 sekundach
                            }
                        }) {
                            Image(systemName: "questionmark.circle")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(Color.white.opacity(0.7))
                        }
                    }
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.9))
                            .frame(height: 45)
                            .shadow(radius: 2)
                        
                        TextField("", text: $pin)
                            .onChange(of: pin, perform: { newValue in
                                self.pin = newValue
                            })
                            .font(.system(size: 20, weight: .thin))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .frame(height: 45)
                            .padding(.horizontal, 10)
                            .foregroundColor(.black.opacity(0.8))
                       
                    }
                    
                    TextFieldHint(hint: pinHint)
                }
                .overlay(
                        Group {
                            if showHelpPIN {
                                Text("Wprowadź 4-cyfrowy kod. Jest on niezbędny do zarządzania kontem w zakładce kontrola rodzicielska.")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.secondary)
                                    .cornerRadius(10)
                                    .transition(.opacity)
                            }
                        }
                    )
                
                //MARK: - Password
                VStack(alignment: .leading, spacing: 11) {
                    TextFieldName(name: "Hasło")
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.9))
                            .frame(height: 45)
                            .shadow(radius: 2)
                        
                        SecureField("", text: $password)
                            .onChange(of: password, perform: { newValue in
                                self.password = newValue
                            })
                            .font(.system(size: 20, weight: .thin))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .frame(height: 45)
                            .padding(.horizontal, 10)
                            .foregroundColor(.black.opacity(0.8))
                    }
                    
                    TextFieldHint(hint: passwordHint)
                }
                
                //MARK: - RegisterButton
                Button {
                    viewModel.signUp(email: login, password: password, name: name, age: age, pin: pin)
                } label: {
                    Text("Zarejestruj się")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .frame(width: 200, height: 40, alignment: .center)
                }
                .disabled((isValidLogin && isValidPassword && (name != "") && isValidAge && isValidPIN) == false)
                .background(isValidLogin && isValidPassword && isValidAge && isValidPIN ? Color("BabyBlueColor") : .secondary)
                .cornerRadius(5)

                Spacer()

                HStack{
                    Text("Masz już konto?")
                        .foregroundColor(.black.opacity(0.7))

                    NavigationLink("Zaloguj się", destination: LoginView())
                        .font(.system(size: 18))
                        .foregroundColor(Color.white)
                    
                }

            }
            .padding()
        }
        .background(Color.accentColor.ignoresSafeArea())
        .navigationBarBackButtonHidden()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
