//
//  AllUserQuestions.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 22/11/2023.
//

import SwiftUI

struct AllUserQuestions: View {
    var set = ""
    @StateObject private var questionVM = QuestionViewModel()

    var body: some View {
        List {
            Section {
                ForEach(questionVM.userQuestions, id: \.id) { question in
                    VStack(alignment: .leading) {
                        Text(question.question ?? "")
                            .font(.headline)
                        Text("Odpowiedź: \(question.answer ?? "")")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
                .onDelete(perform: deleteQuestion)
            } header: {
                Text("Twoje pytania")
                    .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.1))
                    .foregroundColor(Color.white)
                    .textCase(.none)
                    .shadow(radius: 2)
            }
        }
        .onAppear {
            questionVM.loadUserQuestion(set)
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
    }

    func deleteQuestion(at offsets: IndexSet) {
        if let index = offsets.first, index < questionVM.userQuestions.count {
            let questionToDelete = questionVM.userQuestions[index]
            
            questionVM.deleteQuestion(questionToDelete, set: set)
        }
    }
}

