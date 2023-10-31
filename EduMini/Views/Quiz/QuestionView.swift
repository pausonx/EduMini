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
                        
                        Text("Dobra robota!")
                            .font(.title)
                            
                        HStack(spacing: 15){
                            Image(systemName: "checkmark")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                            
                            Text("\(correct)")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                            
                            Image(systemName: "xmark")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                                .padding(.leading)
                            
                            Text("\(wrong)")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                        }
                        
                        Button(action: {
                            present.wrappedValue.dismiss()
                            answered = 0
                            correct = 0
                            wrong = 0
                        }, label: {
                            Text("Powrót")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 150)
                                .background(Color.blue)
                                .cornerRadius(15)
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
                                    .font(.largeTitle)
                                    .foregroundColor(.black)
                            }, icon: {
                                Image(systemName: "checkmark")
                                    .font(.largeTitle)
                                    .foregroundColor(.green)
                            })
                            
                            Spacer()
                            
                            Label(title: {
                                Text(wrong == 0 ? "" : "\(wrong)")
                                    .font(.largeTitle)
                                    .foregroundColor(.black)
                            }, icon: {
                                Image(systemName: "xmark")
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                            })
                        }
                        .padding()
                        
                        
                        ZStack {
                            ForEach(data.questions.reversed().indices){ index in //zmienić na od 1  do 10
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
        
        
    }
    
    func progess()->CGFloat {
        let fraction = CGFloat(answered)/CGFloat(data.questions.count) //zmienić na 10 jak będzie baza uzupełniona i działająca
        let width = UIScreen.main.bounds.width - 30
        return fraction * width
    }
}

struct OnlyQuestionView: View {
    @Binding var question: Question
    @Binding var correct: Int
    @Binding var wrong: Int
    @Binding var answered: Int
    
    @State var selected = ""
    
    var body: some View {
        VStack (spacing: 20) {
            Text(question.question!)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .padding(.top, 25)
            
            Spacer()
            
            Button(action: {selected = question.optionA!}, label: {
                Text(question.optionA!)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(color(option: question.optionA!), lineWidth: 1)
                    )
            })
            
            Button(action: {selected = question.optionB!}, label: {
                Text(question.optionB!)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(color(option: question.optionB!), lineWidth: 1)
                    )
            })
            
            Button(action: {selected = question.optionC!}, label: {
                Text(question.optionC!)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(color(option: question.optionC!), lineWidth: 1)
                    )
            })
            
            Button(action: {selected = question.optionD!}, label: {
                Text(question.optionD!)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(color(option: question.optionD!), lineWidth: 1)
                    )
            })
            
            Spacer()
            
            HStack {
                Button(action: checkAnswer, label: {
                    Text("Potwierdź")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                    
                })
                .disabled(question.isSubmitted ? true : false)
                .opacity(question.isSubmitted ? 0.7 : 1)
                
                Button(action: {
                    withAnimation{
                        question.completed.toggle()
                        answered += 1
                    }
                }, label: {
                    Text("Dalej")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                })
                .disabled(!question.isSubmitted ? true : false)
                .opacity(!question.isSubmitted ? 0.7 : 1)
            }
            .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
        
    }
    
    
    func color(option: String)->Color{
        if option == selected {
            if question.isSubmitted {
                if selected == question.answer! {
                    return Color.green
                } else {
                    return Color.red
                }
            } else {
                return Color.blue
            }
        } else {
            
            if question.isSubmitted && option != selected {
                if question.answer! == option {
                    return Color.green
                }
            }
            return Color.gray
        }
    }
    
    func checkAnswer(){
        if selected == question.answer! {
            correct += 1
        } else {
            wrong += 1
        }
        
        question.isSubmitted.toggle()
    }
}
