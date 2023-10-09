//
//  HelloPage.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 07/08/2023.
//

import SwiftUI

struct HelloPage: View {
    
    @EnvironmentObject var viewModel: AppViewModel

    
    var body: some View {
        ZStack {
            Image("hellopagebg")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
                .background(Color.clear)

            VStack(spacing: 20) {
            
                VStack {
                    Image(systemName: "graduationcap")
                        .font(.system(size: 80, weight: .thin))
                        .frame(height: 120, alignment: .bottom)
                        .foregroundColor(Color.white)
                    
                    Text("Witaj w EduMini!")
                        .font(.system(size: UIScreen.main.bounds.width * 0.11, weight: .thin))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                }
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.3)
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(20)
                
                Text("Jest to aplikacja stworzona z myślą o wspieraniu nauki dzieci na ich początkowym etapie ich edukacji")
                    .font(.system(size: 20, weight: .thin))
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.15)
                    .padding()
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(20)

                
                
                Spacer()
                
                NavigationLink(destination: LoginView()) { // Adding the navigation link
                    Text("Zaloguj się")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .frame(width: 200, height: 20, alignment: .center)
                }
                .buttonStyle(BStyle1())
                
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10){
                    HStack {
                        Text("Nie masz konta?")
                            .foregroundColor(.black.opacity(0.7))
                        
                        NavigationLink("Zarejestruj się!", destination: RegisterView())
                            .font(.system(size: 18))
                            .foregroundColor(Color("DarkBabyBlueColor"))
                    }
                }
                .padding()
                                
                
            }
            .padding()
        }
    }
}


struct BStyle1: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? Color.gray.opacity(0.7) : Color.gray)
            .cornerRadius(5)
    }
}

struct HelloPage_Previews: PreviewProvider {
    static var previews: some View {
        HelloPage()
    }
}
