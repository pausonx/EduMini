//
//  ToDoView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 13/08/2023.
//

import SwiftUI

struct ToDoView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("profileBG") // Ustawienie obrazu jako tło
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                    .background(Color.clear)
                
                VStack {
                    Text("Tu jest zawartość strony ToDo")
                    // Dodaj inne elementy
                }
            }
        }
        .tabItem {
            Label("ToDo", systemImage: "checklist")
        }
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}
