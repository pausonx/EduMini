//
//  AddNewCardView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 10/10/2023.
//

import SwiftUI

struct AddNewCardView: View {
    @Binding var showAddView: Bool
    @ObservedObject var viewModel = FlashcardViewModel()
    @EnvironmentObject var flashcardVM: FlashcardViewModel

    @State var question = ""
    @State var answer = ""
    @State var topic = ""
    @State var fliping: Bool = false
    
    var body: some View {
        VStack(spacing: 10){
            VStack(alignment: .leading, spacing: 10){
                HStack {
                    TextField("Temat", text: $topic).bold()
                        .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.1))
                        .foregroundColor(.black)
                        .autocorrectionDisabled()

                    
                    
                    Button {
                        showAddView = false
                    } label: {
                        Image(systemName: "xmark").bold()
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
                
                Text("Pytanie").bold()
                TextEditor(text: $question).bold()
                    .frame(height: 80)
                    .background(Color.gray)
                    .opacity(0.7)
                    .cornerRadius(10)
                    .autocorrectionDisabled()

                
                Text("Odpowiedź").bold()
                TextEditor(text: $answer).bold()
                    .frame(height: 80)
                    .background(Color.gray)
                    .opacity(0.7)
                    .cornerRadius(10)
                    .autocorrectionDisabled()

            }
            .padding()
            
            Button {
                flashcardVM.addFlashcard(topic: topic, question: question, answer: answer, fliping: fliping)
                showAddView = false
            } label: {
                Text("Dodaj")
                    .foregroundColor(.white)
                    .frame(width: 230, height: 40)
                    .background(Color("DarkBabyBlueColor"))
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
    }
}


#Preview {
    AddNewCardView(showAddView: .constant(false))
        .environmentObject(FlashcardViewModel())
}
