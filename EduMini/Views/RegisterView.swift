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
    @State private var nick: String = ""
    
    @State var isOn: Bool = false
    
    @State private var showHelpAge = false
    @State private var showHelpPIN = false
    @State private var showHelpEmail = false
    @State private var showRules = false

    @EnvironmentObject var viewModel: AppViewModel

    @ObservedObject private var UserProfileVM = UserProfileViewModel()
    
    @State private var emailInUse = false
    @State private var nickInUse = false
    
    func isEmailUnique(_ email: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        usersCollection.whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Błąd podczas sprawdzania unikalności e-maila: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let documents = querySnapshot?.documents, !documents.isEmpty {
                // E-mail jest już w użyciu
                completion(false)
            } else {
                // E-mail jest unikalny
                completion(true)
            }
        }
    }
    
    func isNickUnique(_ nick: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        usersCollection.whereField("nick", isEqualTo: nick).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Błąd podczas sprawdzania unikalności nicku: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let documents = querySnapshot?.documents, !documents.isEmpty {
                // Nick jest już w użyciu
                completion(false)
            } else {
                // Nick jest unikalny
                completion(true)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Background(title: "hellopagebg")
            
            ScrollView {
                
                VStack(spacing: 10) {
                    Text("Rejestracja")
                        .font(.system(size: 50, weight: .thin))
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1, alignment: .bottom)
                        .foregroundColor(Color.white)
                        .padding()
                                 
                    
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
                                .frame(height: UIScreen.main.bounds.height * 0.05)
                                .shadow(radius: 2)
                            
                            TextField("", text: $login)
                                .onChange(of: login) { oldValue, newValue in
                                    self.login = newValue
                                }
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
                                    .background(Color("DarkBabyBlueColor"))
                                    .cornerRadius(10)
                                    .transition(.opacity)
                            }
                        }
                    )
                    
                    //MARK: - Name
                    VStack(alignment: .leading, spacing: 10) {
                        TextFieldName(name: "Imię")
                        
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.9))
                                .frame(height: UIScreen.main.bounds.height * 0.05)
                                .shadow(radius: 2)
                            
                            TextField("", text: $name)
                                .onChange(of: name) { oldValue, newValue in
                                    self.name = newValue
                                }
                                .font(.system(size: 20, weight: .thin))
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .frame(height: 45)
                                .padding(.horizontal, 10)
                                .foregroundColor(.black.opacity(0.8))
                            
                        }
                    }
                    
                    //MARK: - Nick
                    VStack(alignment: .leading, spacing: 10) {
                        TextFieldName(name: "Nick")
                        
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.9))
                                .frame(height: UIScreen.main.bounds.height * 0.05)
                                .shadow(radius: 2)
                            
                            TextField("", text: $nick)
                                .onChange(of: nick) { oldValue, newValue in
                                    self.nick = newValue
                                }
                                .font(.system(size: 20, weight: .thin))
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .frame(height: 45)
                                .padding(.horizontal, 10)
                                .foregroundColor(.black.opacity(0.8))
                            
                        }
                    }
                    
                    HStack {
                        
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
                                    .frame(height: UIScreen.main.bounds.height * 0.05)
                                    .shadow(radius: 2)
                                
                                TextField("", text: $age)
                                    .onChange(of: age) { oldValue, newValue in
                                        self.age = newValue
                                    }
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
                                    Text("Wprowadź liczbę.")
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color("DarkBabyBlueColor"))
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
                                    .frame(height: UIScreen.main.bounds.height * 0.05)
                                    .shadow(radius: 2)
                                
                                TextField("", text: $pin)
                                    .onChange(of: pin) { oldValue, newValue in
                                        self.pin = newValue
                                    }
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
                                    Text("Wprowadź 4-cyfrowy kod.")
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color("DarkBabyBlueColor"))
                                        .cornerRadius(10)
                                        .transition(.opacity)
                                }
                            }
                        )
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
                                .onChange(of: password) { oldValue, newValue in
                                    self.password = newValue
                                }
                                .font(.system(size: 20, weight: .thin))
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .frame(height: 45)
                                .padding(.horizontal, 10)
                                .foregroundColor(.black.opacity(0.8))
                        }
                        
                        TextFieldHint(hint: passwordHint)
                    }
                    
                    VStack {
                        HStack {
                            Button(action: {
                                showRules = true // Pokaż instrukcję
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    showRules = false // Ukryj regulamin po 5 sekundach
                                }
                            }) {
                                Image(systemName: "exclamationmark.shield.fill")
                                    .font(.system(size: 40, weight: .medium))
                                    .foregroundColor(Color("DarkBabyBlueColor").opacity(0.7))
                            }
                            Toggle("Zapoznałem/am się z regulaminem i akceptuję jego treść", isOn: $isOn)
                                .foregroundColor(Color.black.opacity(0.8))
                                .frame(height: UIScreen.main.bounds.height * 0.1)

                        }
                    }
                    .overlay(
                        Group {
                            if showRules {
                                Text("Wyrażam zgodę na przetwarzanie danych osobowych na potrzeby korzystania z aplikacji.")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color("DarkBabyBlueColor"))
                                    .cornerRadius(10)
                                    .transition(.opacity)
                            }
                        }
                    )
                    
                    //MARK: - RegisterButton
                    Button {
                        isEmailUnique(login) { isUniqueEmail in
                            if isUniqueEmail {
                                isNickUnique(nick) { isUniqueNick in
                                    if isUniqueNick {
                                        viewModel.signUp(email: login, password: password, name: name, nick: nick, age: age, pin: pin)
                                    } else {
                                        nickInUse = true
                                    }
                                }
                            } else {
                                emailInUse = true
                            }
                        }
                    } label: {
                        Text("Zarejestruj się")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .frame(width: 200, height: 40, alignment: .center)
                    }
                    .disabled(!(isValidLogin && isValidPassword && !name.isEmpty && !nick.isEmpty && isValidAge && isValidPIN && isOn))
                    .background(isValidLogin && isValidPassword && isValidAge && isValidPIN && isOn ? Color("DarkBabyBlueColor") : .gray)
                    .cornerRadius(5)
                    
                    if emailInUse {
                        Text("Adres e-mail jest już w użyciu. Wybierz inny adres e-mail.")
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.top, 5)
                    }

                    if nickInUse {
                        Text("Nick jest już zajęty. Wybierz inny nick.")
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.top, 5)
                    }
                    
                    HStack{
                        Text("Masz już konto?")
                            .foregroundColor(.black.opacity(0.7))
                        
                        NavigationLink("Zaloguj się", destination: LoginView())
                            .font(.system(size: 18))
                            .foregroundColor(Color("DarkBabyBlueColor"))
                        
                    }
                    
                }
                .padding()
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
