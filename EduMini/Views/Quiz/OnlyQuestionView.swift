//
//  OnlyQuestionView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 02/11/2023.
//

import SwiftUI

struct OnlyQuestionView: View {
    @Binding var question: Question
    @Binding var correct: Int
    @Binding var wrong: Int
    @Binding var answered: Int
    
    @State var selected = ""
    
    var body: some View {
        VStack (spacing: 20) {
            ZStack{
                Text(question.question!)
                    .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.07))
                    .foregroundColor(.black)
                    .padding(.top, 25)
                    .multilineTextAlignment(.center)
            }
            .frame(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.width * 0.35)
            .padding()
            .background(Color.white)
            .cornerRadius(25)
            .shadow(radius: 2)
            
            Spacer()
            
            HStack {
                Button(action: {selected = question.optionA!}, label: {
                    VStack{
                        Image(systemName: "a.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 40)
                            .foregroundColor(Color.yellow)
                        
                        Text(question.optionA!)
                            .foregroundColor(.black)
                            .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.05))
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                        
                })
                .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.width * 0.35)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(color(option: question.optionA!), lineWidth: 5)
                        .fill(Color.white)
                )
                .padding(.horizontal)
                
                Button(action: {selected = question.optionB!}, label: {
                    VStack{
                        Image(systemName: "b.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 40)
                            .foregroundColor(Color.green)
                        
                        Text(question.optionB!)
                            .foregroundColor(.black)
                            .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.05))                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                        
                })
                .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.width * 0.35)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(color(option: question.optionB!), lineWidth: 5)
                        .fill(Color.white)
                )
                .padding(.horizontal)
            }
            
            HStack {
                Button(action: {selected = question.optionC!}, label: {
                    VStack{
                        Image(systemName: "c.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 40)
                            .foregroundColor(Color.red)
                        
                        Text(question.optionC!)
                            .foregroundColor(.black)
                            .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.05))                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                        
                })
                .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.width * 0.35)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(color(option: question.optionC!), lineWidth: 5)
                        .fill(Color.white)
                )
                .padding(.horizontal)
                
                Button(action: {selected = question.optionD!}, label: {
                    VStack{
                        Image(systemName: "d.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 40)
                            .foregroundColor(Color.purple)
                        
                        Text(question.optionD!)
                            .foregroundColor(.black)
                            .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.05))                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                        
                })
                .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.width * 0.35)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(color(option: question.optionD!), lineWidth: 5)
                        .fill(Color.white)
                )
                .padding(.horizontal)
            }
            
            HStack {
                Button(action: checkAnswer, label: {
                    Text("Potwierdź")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("DarkBabyBlueColor"))
                        .cornerRadius(15)
                    
                })
                .disabled(question.isSubmitted ? true : false)
                .opacity(question.isSubmitted ? 0.6 : 1)
                
                Button(action: {
                    withAnimation{
                        question.completed.toggle()
                        answered += 1
                    }
                }, label: {
                    Text("Dalej")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("DarkBabyBlueColor"))
                        .cornerRadius(15)
                })
                .disabled(!question.isSubmitted ? true : false)
                .opacity(!question.isSubmitted ? 0.6 : 1)
            }
            .padding()
        }
        .padding()
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
                return Color("DarkBabyBlueColor")
            }
        } else {
            
            if question.isSubmitted && option != selected {
                if question.answer! == option {
                    return Color.green
                }
            }
            return Color.gray.opacity(0.7)
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

