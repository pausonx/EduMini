//
//  AddNewQuestion.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 22/11/2023.
//

import SwiftUI

struct AddNewQuestion: View {
    var set = ""
    @State private var question = ""
    @State private var answer = ""
    @State private var level = ""
    @State private var optionA = ""
    @State private var optionB = ""
    @State private var optionC = ""
    @State private var optionD = ""
    @State private var isQuestionAdded = false
    @State private var hint = false

    @ObservedObject var questionViewModel = QuestionViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Pytanie")) {
                    TextField("Treść pytania", text: $question)
                }

                Section(header: Text("Odpowiedź")) {
                    TextField("Poprawna odpowiedź", text: $answer)
                }

                Section(header: Text("Opcje odpowiedzi")) {
                    TextField("Opcja A", text: $optionA)
                    TextField("Opcja B", text: $optionB)
                    TextField("Opcja C", text: $optionC)
                    TextField("Opcja D", text: $optionD)
                }

                Section(header: Text("Poziom trudności")) {
                    Picker("Poziom", selection: $level) {
                        ForEach(["L1", "L2", "L3"], id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section {
                    Button(action: addQuestion) {
                        HStack{
                            Text(isQuestionAdded ? "Dodano pytanie" : "Dodaj pytanie")
                                .foregroundColor(isQuestionAdded ? Color.green : Color.primary)
                            Spacer()
                            Text(hint ? "Uzupełnij wszystkie pola!" : "")
                                .foregroundColor(Color.red)
                                .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.03))
                        }
                    }
                    .onChange(of: isQuestionAdded) { _, x in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            clearForm()
                        }
                    }
                    
                }
            }
        }
    }

    func addQuestion() {
        if (question.isEmpty || answer.isEmpty || optionA.isEmpty || optionB.isEmpty || optionC.isEmpty || optionD.isEmpty || level.isEmpty) {
            print("Uzupełnij wszystkie pola!")
            hint = true
        } else {
            questionViewModel.addQuestion(set: set, question: question, answer: answer, level: level, a: optionA, b: optionB, c: optionC, d: optionD)
            isQuestionAdded = true
        }
    }

    func clearForm() {
        question = ""
        answer = ""
        level = ""
        optionA = ""
        optionB = ""
        optionC = ""
        optionD = ""
        isQuestionAdded = false
    }
}

#Preview {
    AddNewQuestion()
}
