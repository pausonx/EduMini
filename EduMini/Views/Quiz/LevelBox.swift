//
//  LevelBox.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 02/11/2023.
//

import SwiftUI

struct LevelBox : View {
    @State var color: String
    @State var name: String
    @State var image: String

    var body: some View {
        ZStack {
            VStack {
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                    .padding()
                    .foregroundColor(Color(color))
                
                
                Text(name)
                    .multilineTextAlignment(.center)
                    .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.05))
                    .foregroundColor(Color("DarkGrayColor"))
                    .padding(5)
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.95))
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}
