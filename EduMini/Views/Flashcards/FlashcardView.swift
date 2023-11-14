//
//  FlashcardView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 06/11/2023.
//

import SwiftUI

struct FlashcardView: View {
    @EnvironmentObject var flashcardVM: FlashcardViewModel

    var topic = ""
    var question = ""
    var answer = ""
    @State var fliping = false
    @State var shouldDisapper = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color(.white))
                .shadow(radius: 10)
                .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.5)
                .rotation3DEffect(.degrees(fliping ? 180 : 0),axis: (x: 0.0, y: 1.0, z: 0.0))


            VStack(alignment: .leading){
                if fliping {
                    Text(topic)
                        .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.07))
                        .foregroundColor(.black)
                    
                    Text(answer)
                        .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.06))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.4)
                } else {
                    Text(topic)
                        .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.07))
                        .foregroundColor(.black)
                    
                    Text(question)
                        .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.06))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.4)
                }
                
            }
            .opacity(shouldDisapper ? 0 : 1)
            
            
        }
        .onTapGesture {
            shouldDisapper.toggle()
            withAnimation(.easeInOut(duration: 0.5)) {
                fliping.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    shouldDisapper = false
                }
            }
        }
    }
}
