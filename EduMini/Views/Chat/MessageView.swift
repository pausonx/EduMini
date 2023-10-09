//
//  MessageView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 09/10/2023.
//

import SwiftUI

struct MessageView: View {
    let message: ChatMessage
    
    var body: some View {
        VStack{
            if message.fromId == FirebaseManager.shared.auth.currentUser?.uid {
                HStack {
                    Spacer()
                    HStack {
                        Text(message.text)
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                    }
                    .padding(10)
                    .background(Color("DarkBabyBlueColor"))
                    .cornerRadius(25)
                }
            } else {
                HStack {
                    HStack {
                        Text(message.text)
                            .font(.system(size: 15))
                    }
                    .padding(10)
                    .background(Color(UIColor(.gray.opacity(0.2))))
                    .cornerRadius(25)
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
    }
}
