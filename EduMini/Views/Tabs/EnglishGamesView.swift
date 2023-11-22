//
//  EnglishGamesView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 02/11/2023.
//

import SwiftUI

struct EnglishGamesView: View {
    
    @State var show = false
    @State var showAdd = false
    @State var showQuestions = false
    @State var set = "english_quiz"
    @State var level = "L1"
    
    @State var correct = 0
    @State var wrong = 0
    @State var answered = 0
    
    @StateObject var questionVM = QuestionViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Background(title: "hellopagebg")
                
                ScrollView {
                    VStack (spacing: 15) {
                        Spacer()
                        QuizTitle(title: "Gry z j.angielskiego")
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), content: {
                            
                            ZStack {
                                Text("TWÓJ QUIZ")
                                    .multilineTextAlignment(.center)
                                    .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.04))
                                    .foregroundColor(Color("DarkGrayColor"))
                                    .padding(5)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.95))
                            .cornerRadius(15)
                            .shadow(radius: 10)
                            .onTapGesture {
                                level = "L0"
                                questionVM.loadUserQuestion(set)
                                show.toggle()
                            }
                            
                            ZStack {
                                Text("DODAJ PYTANIA")
                                    .multilineTextAlignment(.center)
                                    .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.04))
                                    .foregroundColor(Color("DarkGrayColor"))
                                    .padding(5)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.95))
                            .cornerRadius(15)
                            .shadow(radius: 10)
                            .onTapGesture {
                                showAdd.toggle()
                            }
                            
                            ZStack {
                                Text("POKAŻ PYTANIA")
                                    .multilineTextAlignment(.center)
                                    .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.04))
                                    .foregroundColor(Color("DarkGrayColor"))
                                    .padding(5)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.95))
                            .cornerRadius(15)
                            .shadow(radius: 10)
                            .onTapGesture {
                                showQuestions.toggle()
                            }
                            
                        })
                        .padding()
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), content: {
                            
                            LevelBox(color: "GreenGradient1", name: "POZIOM ŁATWY", image: "1.circle.fill")
                                .onTapGesture {
                                    level = "L1"
                                    show.toggle()
                                }
                            
                            LevelBox(color: "GreenGradient2", name: "POZIOM ŚREDNI", image: "2.circle.fill")
                                .onTapGesture {
                                    level = "L2"
                                    show.toggle()
                                }
                            
                            LevelBox(color: "GreenGradient3", name: "POZIOM TRUDNY", image: "3.circle.fill")
                                .onTapGesture {
                                    level = "L3"
                                    show.toggle()
                                }
                            
                            LevelBox(color: "EmeraldColor", name: "TRYB MIESZANY", image: "4.circle.fill")
                                .onTapGesture {
                                    level = "L4"
                                    show.toggle()
                                }
                            
                        })
                        .padding()

                        
                    }
                    .navigationBarHidden(true)
                    .sheet(isPresented: $show, content: {
                        QuestionView(correct: $correct, wrong: $wrong, answered: $answered, set: set, level: level)
                    })
                    .sheet(isPresented: $showAdd, content: {
                        AddNewQuestion(set: set)
                    })
                    .sheet(isPresented: $showQuestions, content: {
                        AllUserQuestions(set: set)
                    })
                    .onAppear {
                        questionVM.loadUserQuestion(set)
                    }
                }
            }
            
        }
    }
}

#Preview {
    EnglishGamesView()
}
