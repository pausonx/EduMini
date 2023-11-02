//
//  LoginView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 07/08/2023.
//

import SwiftUI

struct LoginView: View {
    
    @State private var isValidLogin: Bool = false
    @State private var isValidPassword: Bool = false
    @State private var loginHint: String = ""
    @State private var passwordHint: String = ""
    
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
    
    @EnvironmentObject var viewModel: AppViewModel

    
    var body: some View {
        ZStack {
            Background(title: "hellopagebg")
            
            VStack(spacing: 20) {
                Text("Logowanie")
                    .font(.system(size: 50, weight: .thin))
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1, alignment: .bottom)
                    .foregroundColor(Color.white)
                    .padding()
                
                Text("Podaj adres email i hasło by zalogować")
                    .font(.system(size: 20, weight: .thin))
                    .padding(.vertical)
                
                
                //MARK: - Login
                VStack(alignment: .leading, spacing: 10) {
                    TextFieldName(name: "Email")

                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.9))
                            .frame(height: UIScreen.main.bounds.height * 0.05)
                            .shadow(radius: 2)

                        TextField("", text: $login)
                            .font(.system(size: 20, weight: .thin))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .frame(height: UIScreen.main.bounds.height * 0.05)
                            .padding(.horizontal, 10)
                            .foregroundColor(.black.opacity(0.8))
                    }

                    TextFieldHint(hint: loginHint)
                }
                .onChange(of: login) { oldValue, newValue in
                    self.login = newValue
                }


                
                //MARK: - Password
                VStack(alignment: .leading, spacing: 11) {
                    TextFieldName(name: "Hasło")

                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.9))
                            .frame(height: UIScreen.main.bounds.height * 0.05)
                            .shadow(radius: 2)
                        
                        SecureField("", text: $password)
                            .font(.system(size: 20, weight: .thin))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .frame(height: UIScreen.main.bounds.height * 0.05)
                            .padding(.horizontal, 10)
                            .foregroundColor(.black.opacity(0.8))
                    }

                    TextFieldHint(hint: passwordHint)
                }
                .onChange(of: password) { oldValue, newValue in
                    self.password = newValue
                }

                                
                //MARK: - SignInButton
                Button {
                    viewModel.signIn(email: login, password: password)
                } label: {
                    Text("Zaloguj się")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .frame(width: 200, height: 40, alignment: .center)
                }
                .disabled((isValidLogin && isValidPassword) == false)
                .background(isValidLogin && isValidPassword ? Color("DarkBabyBlueColor") : .gray)
                .cornerRadius(5)
                .padding(.bottom, UIScreen.main.bounds.height * 0.3)

                
                HStack{
                    Text("Nie masz jeszcze konta?")
                        .foregroundColor(.black.opacity(0.7))
                    NavigationLink("Zarejestruj się", destination: RegisterView())
                        .font(.system(size: 18))
                        .foregroundColor(Color("DarkBabyBlueColor"))
                }
                .padding()

            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
