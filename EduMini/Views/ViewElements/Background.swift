//
//  Background.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 02/11/2023.
//

import SwiftUI

struct Background: View {
    @State var title: String
    var body: some View {
        Image(title)
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .edgesIgnoringSafeArea(.all)
            .background(Color.clear)
    }
}

#Preview {
    Background(title: "hellopagebg")
}
