//
//  UpdateCardView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 10/10/2023.
//

import SwiftUI

struct UpdateCardView: View {
    @State var selectedQuestion: Flashcard?
    @Binding var newTopic: String
    @Binding var newQuestion: String
    @Binding var newAnswer: String
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var flashcardVM: FlashcardViewModel
    
    var body: some View {
        VStack(spacing: 10){
            VStack(alignment: .leading, spacing: 10){
                HStack {
                    TextField("Temat", text: $newTopic).bold()
                        .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.1))
                        .foregroundColor(.black)
                    
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark").bold()
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
                
                Text("Pytanie").bold()
                TextEditor(text: $newQuestion).bold()
                    .frame(height: 80)
                    .background(Color.gray)
                    .opacity(0.7)
                    .cornerRadius(10)
                
                Text("Odpowiedź").bold()
                TextEditor(text: $newAnswer).bold()
                    .frame(height: 80)
                    .background(Color.gray)
                    .opacity(0.7)
                    .cornerRadius(10)
            }
            .padding()
            
            Button {
                flashcardVM.updateCard(flashcard: selectedQuestion!, newTopic: newTopic, newQuestion: newQuestion, newAnswer: newAnswer)
                    dismiss()
            } label: {
                Text("Zapisz")
                    .foregroundColor(.white)
                    .frame(width: 230, height: 40)
                    .background(Color("DarkBabyBlueColor"))
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
    }
}

//#Preview {
//    UpdateCardView()
//}
