//
//  AuthorView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 22/11/2023.
//

import SwiftUI

struct AuthorView: View {
    var body: some View {
        ZStack {
            Background(title: "profileBG")
            VStack{
                HStack {
                    Text("Ta aplikacja została stworzona w ramach pracy inżynierskiej pt. \"Edukacyjna aplikacja mobilna dla dzieci\"\nAutor: Paulina Wyskiel \nnr albumu: 139555 \nPolitechnika Krakowska \nWydział Inżynierii Elektrycznej i Komputerowej \nKierunek: Informatyka w Inżynierii Komputerowej")
                        .font(.system(size: 19, weight: .light))
                }
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.30)
                .padding()
                .background(Color.white.opacity(0.95))
                .cornerRadius(20)
                .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    AuthorView()
}
