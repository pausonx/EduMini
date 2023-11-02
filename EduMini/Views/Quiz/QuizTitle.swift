//
//  QuizTitle.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 02/11/2023.
//

import SwiftUI

struct QuizTitle: View {
    @State var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.08))
                .padding(.top,UIScreen.main.bounds.height * 0.05)
                .padding(.horizontal, UIScreen.main.bounds.height * 0.03)
                .foregroundColor(Color.white)
                .shadow(radius: 1)
                .padding(.top, 20)
            
            Spacer()
        }
    }
}

#Preview {
    QuizTitle(title: "Test")
}
