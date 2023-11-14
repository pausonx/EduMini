//
//  QuestionView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 31/10/2023.
//

import SwiftUI

struct QuestionView: View {
    @Binding var correct: Int
    @Binding var wrong: Int
    @Binding var answered: Int
    var set: String
    var level: String
    @StateObject var data = QuestionViewModel()
    @Environment(\.presentationMode) var present

    @StateObject private var firebaseRepository = FirebaseRepository.shared

    var body: some View {
        ZStack{
            if data.questions.isEmpty {
                ProgressView()
            } else {
                if answered == data.questions.count {
                    VStack(spacing: 25){
                        Image(systemName: "trophy.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250, height: 250)
                            .foregroundColor(Color("SunglowColor"))
                            .shadow(radius: 10)

                        Text("Dobra robota!")
                            .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.1))
                            .foregroundColor(Color.white)

                        HStack(spacing: 15){
                            Image(systemName: "checkmark")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                                .shadow(radius: 2)

                            Text("\(correct)")
                                .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.1))
                                .foregroundColor(.white)

                            Image(systemName: "xmark")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                                .padding(.leading)
                                .shadow(radius: 2)


                            Text("\(wrong)")
                                .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.1))
                                .foregroundColor(.white)
                        }

                        Button(action: {
                            updatePointsForCurrentUser()

                            present.wrappedValue.dismiss()
                            answered = 0
                            correct = 0
                            wrong = 0
                        }, label: {
                            Text("Powrót")
                                .bold()
                                .foregroundColor(Color.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 150)
                                .background(Color("DarkBabyBlueColor"))
                                .cornerRadius(10)
                                .shadow(radius: 10)
                        })
                    }
                } else {
                    VStack{
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                            Capsule()
                                .fill(Color.gray.opacity(0.7))
                                .frame(height: 6)

                            Capsule()
                                .fill(Color.green)
                                .frame(width: progess(), height: 6)
                        }
                        .padding()

                        HStack {
                            Label(title: {
                                Text(correct == 0 ? "" : "\(correct)")
                                    .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.1))
                                    .foregroundColor(.black)
                            }, icon: {
                                Image(systemName: "checkmark")
                                    .bold()
                                    .font(.largeTitle)
                                    .foregroundColor(.green)
                            })

                            Spacer()

                            Label(title: {
                                Text(wrong == 0 ? "" : "\(wrong)")
                                    .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.1))
                                    .foregroundColor(.black)
                            }, icon: {
                                Image(systemName: "xmark")
                                    .bold()
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                            })
                        }
                        .padding()

                        ZStack {
                            ForEach(data.questions.reversed().indices){ index in
                                OnlyQuestionView(question: $data.questions[index], correct: $correct, wrong: $wrong, answered: $answered)
                                    .offset(x: data.questions[index].completed ? 1000 : 0)
                                    .rotationEffect(.init(degrees: data.questions[index].completed ? 10 : 0))
                            }
                        }
                    }
                }


            }
        }
        .onAppear(perform: {
            data.getQuestions(set: set, level: level)
        })
        .background(
            Image("profileBG")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
                .background(Color.clear)
        )
    }

    func progess()->CGFloat {
        let fraction = CGFloat(answered)/CGFloat(data.questions.count)
        let width = UIScreen.main.bounds.width - 30
        return fraction * width
    }

    private func updatePointsForCurrentUser() {
        let totalPoints = correct
        firebaseRepository.updatePoints(totalPoints) { error in
            if let error = error {
                print("Failed to update points: \(error)")
            } else {
                print("Points updated successfully!")
            }
        }
    }
}
