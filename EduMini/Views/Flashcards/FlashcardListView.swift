//
//  FlashcardListView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 06/11/2023.
//

import SwiftUI

struct FlashcardListView: View {
    @State var selectedQuestion: Flashcard?
    @State var newTopic = ""
    @State var newQuestion = ""
    @State var newAnswer = ""
    @EnvironmentObject var flashcardVM: FlashcardViewModel
    
    @State private var showHelpDelete = false
    @State private var showHelpUpdate = false

    
    var body: some View {
        List {
            Section {
                ForEach(flashcardVM.flashcards) {
                    items in
                    Button {
                        self.selectedQuestion = items
                        self.newTopic = items.topic
                        self.newQuestion = items.question
                        self.newAnswer = items.answer
                    } label: {
                        VStack(alignment: .leading){
                            Text(items.topic).bold()
                                .foregroundColor(Color.black)
                            Text(items.question)
                                .foregroundColor(Color.black)
                            Text(items.answer)
                                .foregroundColor(Color.gray)
                                .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.03))
                        }
                        .frame(height: 50)
                    }
                }
                .onDelete(perform: flashcardVM.deleteFlashcard)
            } header: {
                Text("Twoje fiszki")
                    .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.1))
                    .foregroundColor(Color.white)
                    .textCase(.none)
                    .shadow(radius: 2)
                
            }
        }
        .scrollContentBackground(.hidden)
        .background(
            Image("profileBG")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
                .background(Color.clear)
        )
        .sheet(item: $selectedQuestion) { items in
            UpdateCardView(selectedQuestion: items, newTopic: $newTopic, newQuestion: $newQuestion, newAnswer: $newAnswer)
                .presentationDetents([.fraction(0.45)])
                .presentationDragIndicator(.visible)
        }
        .navigationBarBackButtonHidden()
        
        
        HStack {
            Button(action: {
                showHelpUpdate = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    showHelpUpdate = false
                }
            }) {
                Image(systemName: "square.and.pencil")
                    .font(.system(size: UIScreen.main.bounds.width * 0.1, weight: .medium))
                    .foregroundColor(Color("DarkBabyBlueColor"))
            }
            Spacer()
            HStack {
                Button(action: {
                    showHelpDelete = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showHelpDelete = false
                    }
                }) {
                    Image(systemName: "trash.square.fill")
                        .font(.system(size: UIScreen.main.bounds.width * 0.1, weight: .medium))
                        .foregroundColor(Color("DarkBabyBlueColor"))
                }
            }
        }
        .padding()
        .overlay(
            Group {
                if showHelpUpdate {
                    Text("Aby edytować zadanie, wybierz je i wpisz nowe dane")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("DarkBabyBlueColor").opacity(0.9))
                        .cornerRadius(10)
                        .transition(.opacity)
                }
            }
        )
        .overlay(
            Group {
                if showHelpDelete {
                    Text("Aby usunąć zadanie, przesuń od prawej do lewej!")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("DarkBabyBlueColor").opacity(0.9))
                        .cornerRadius(10)
                        .transition(.opacity)
                }
            }
        )
    }
}
