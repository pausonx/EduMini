//
//  FlashcardsView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 13/08/2023.
//

import SwiftUI

struct FlashcardsView: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Image("bg") // Ustawienie obrazu jako tło
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .edgesIgnoringSafeArea(.all)
                        .background(Color.clear)
                    
                    VStack {
                        Text("Tu jest zawartość strony fiszek")
                        // Dodaj inne elementy
                    }
                    .navigationBarTitle("Fiszki")
                }
            }
        }
    }
}

struct FlashcardsView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardsView()
    }
}
