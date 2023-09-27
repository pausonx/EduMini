//
//  InstructionView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 13/08/2023.
//

import SwiftUI

struct InstructionView: View {
    var body: some View {
        ZStack {
            Image("profileBG")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
                .background(Color.clear)
            
            VStack {
                
                HStack {
                    Image(systemName: "square.stack.fill")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(Color("BabyBlueColor"))
                        .frame(width: 50, height: 50)
                    
                    Text("Zakładka ta umożliwia przejście do fiszek")
                        .font(.system(size: 16, weight: .light))
                }
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.05)
                .padding()
                .background(Color.white.opacity(0.95))
                .cornerRadius(20)
                
                
                
                HStack {
                    Image(systemName: "checklist")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(Color("BabyBlueColor"))
                        .frame(width: 50, height: 50)
                    
                    Text("Zakładka ta umożliwia przejście do listy ")
                        .font(.system(size: 16, weight: .light)) +
                    Text("Do zrobienia")
                        .font(.system(size: 16, weight: .medium))
                        .italic()
                }
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.05)
                .padding()
                .background(Color.white.opacity(0.95))
                .cornerRadius(20)
                
                HStack {
                    Image(systemName: "message.fill")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(Color("BabyBlueColor"))
                        .frame(width: 50, height: 50)
                    
                    Text("Zakładka ta umożliwia przejście do chatu online z innymi użytkownikami ")
                        .font(.system(size: 16, weight: .light)) +
                    Text("\n\nUwaga! ")
                        .font(.system(size: 14, weight: .bold)) +
                    Text("\nTa opcja może zostać wyłączona w ustawieniach w opcji ")
                        .font(.system(size: 14, weight: .light)) +
                    Text("kontrola rodzicielska ")
                        .font(.system(size: 14, weight: .medium))
                        .italic()
                }
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.17)
                .padding()
                .background(Color.white.opacity(0.95))
                .cornerRadius(20)
                
                HStack {
                    Image(systemName: "person.fill")
                        .font(.system(size: 45, weight: .bold))
                        .foregroundColor(Color("BabyBlueColor"))
                        .frame(width: 50, height: 50)
                    
                    Text("Zakładka ta umożliwia przejście do profilu użytkownika, tam znajduje się opcja  ")
                        .font(.system(size: 16, weight: .light)) +
                    Text("kontrola rodzicielska ")
                        .font(.system(size: 16, weight: .medium))
                        .italic()
                }
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.07)
                .padding()
                .background(Color.white.opacity(0.95))
                .cornerRadius(20)
                
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(Color("BabyBlueColor"))
                        .frame(width: 50, height: 50)
                    
                    Text("Przycisk ten umożliwia szybkie wylogowanie z aplikacji ")
                        .font(.system(size: 16, weight: .light))
                }
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.05)
                .padding()
                .background(Color.white.opacity(0.95))
                .cornerRadius(20)
                
            }
        }
    }
}

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView()
    }
}