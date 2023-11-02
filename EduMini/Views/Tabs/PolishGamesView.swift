//
//  PolishGamesView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 02/11/2023.
//

import SwiftUI

struct PolishGamesView: View {
    
    @State var show = false
    @State var set = "polish_quiz"
    @State var level = "L1"
    
    @State var correct = 0
    @State var wrong = 0
    @State var answered = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                Background(title: "hellopagebg")
                
                ScrollView {
                    VStack (spacing: 15) {
                        Spacer()
                        QuizTitle(title: "Gry z j.polskiego")
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), content: {
                            
                            LevelBox(color: "PinkGradient1", name: "POZIOM ŁATWY", image: "1.circle.fill")
                                .onTapGesture {
                                    level = "L1"
                                    show.toggle()
                                }
                            
                            LevelBox(color: "PinkGradient2", name: "POZIOM ŚREDNI", image: "2.circle.fill")
                                .onTapGesture {
                                    level = "L2"
                                    show.toggle()
                                }
                            
                            LevelBox(color: "PinkGradient3", name: "POZIOM TRUDNY", image: "3.circle.fill")
                                .onTapGesture {
                                    level = "L3"
                                    show.toggle()
                                }
                            
                            LevelBox(color: "BrightPinkColor", name: "TRYB MIESZANY", image: "4.circle.fill")
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
                    
                }
            }
            
        }
    }
}

#Preview {
    PolishGamesView()
}
