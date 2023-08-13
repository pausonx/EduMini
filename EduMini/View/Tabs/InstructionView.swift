//
//  InstructionView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 13/08/2023.
//

import SwiftUI

struct InstructionView: View {
    var body: some View {
        List {
            
            HStack {
                Image(systemName: "square.stack.fill")
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(Color.accentColor)
                    .frame(width: 50, height: 50)
                
                Text("Zakładka ta umożliwia przejście do fiszek")
                    .font(.system(size: 18, weight: .light))
            }
            
            
            HStack {
                Image(systemName: "checklist")
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(Color.accentColor)
                    .frame(width: 50, height: 50)
                
                Text("Zakładka ta umożliwia przejście do listy ")
                    .font(.system(size: 18, weight: .light)) +
                Text("Do zrobienia")
                    .font(.system(size: 18, weight: .medium))
                    .italic()
            }
            
            HStack {
                Image(systemName: "message.fill")
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(Color.accentColor)
                    .frame(width: 50, height: 50)
                
                Text("Zakładka ta umożliwia przejście do chatu online z innymi użytkownikami ")
                    .font(.system(size: 18, weight: .light)) +
                Text("\n\nUwaga! ")
                    .font(.system(size: 16, weight: .bold)) +
                Text("\nTa opcja może zostać wyłączona w ustawieniach w opcji kontrola rodzicielska ")
                    .font(.system(size: 16, weight: .light)) +
                Text("kontrola rodzicielska ")
                    .font(.system(size: 16, weight: .medium))
                    .italic()
            }
            
            
            HStack {
                Image(systemName: "person.fill")
                    .font(.system(size: 45, weight: .bold))
                    .foregroundColor(Color.accentColor)
                    .frame(width: 50, height: 50)
                
                Text("Zakładka ta umożliwia przejście do profilu użytkownika, tam znajduje się opcja kontrola rodzicielska ")
                    .font(.system(size: 18, weight: .light)) +
                Text("kontrola rodzicielska ")
                    .font(.system(size: 18, weight: .medium))
                    .italic()
            }
            
            
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(Color.accentColor)
                    .frame(width: 50, height: 50)
                
                Text("Przycisk ten umożliwia szybkie wylogowanie z aplikacji ")
                    .font(.system(size: 20, weight: .light))
            }
        }
    }
}

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView()
    }
}
