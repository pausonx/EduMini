//
//  MathGamesView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 31/10/2023.
//

import SwiftUI

struct MathGamesView: View {
    
    var color = ""
    @State var show = false
    @State var set = "math_quiz"
    @State var level = "L1"
    
    @State var correct = 0
    @State var wrong = 0
    @State var answered = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("hellopagebg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                    .background(Color.clear)
                
                ScrollView {
                    VStack (spacing: 15) {
                        Spacer()
                        HStack {
                            Text("Gry matematyczne")
                                .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.08))
                                .padding(.top,UIScreen.main.bounds.height * 0.05)
                                .padding(.horizontal, UIScreen.main.bounds.height * 0.03)
                                .foregroundColor(Color.white)
                                .shadow(radius: 1)
                                .padding(.top, 20)
                            
                            Spacer()
                        }
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), content: {
                            
                            ZStack {
                                VStack {
                                    Image(systemName: "1.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 50)
                                        .padding()
                                        .foregroundColor(Color("ColorGradient1"))
                                    
                                    
                                    Text("POZIOM ŁATWY")
                                        .multilineTextAlignment(.center)
                                        .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.05))
                                        .foregroundColor(Color("DarkGrayColor"))
                                        .padding(5)
                                    
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            //                            .background(Color("ColorGradient1").opacity(0.9))
                            .background(Color.white.opacity(0.95))
                            .cornerRadius(15)
                            .shadow(radius: 10)
                            .onTapGesture {
                                level = "L1"
                                show.toggle()
                            }
                            
                            ZStack {
                                VStack {
                                    Image(systemName: "2.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 50)
                                        .padding()
                                        .foregroundColor(Color("ColorGradient2"))
                                    
                                    
                                    Text("POZIOM ŚREDNI")
                                        .multilineTextAlignment(.center)
                                        .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.05))
                                        .foregroundColor(Color("DarkGrayColor"))
                                        .padding(5)
                                    
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            //                            .background(Color("ColorGradient2").opacity(0.9))
                            .background(Color.white.opacity(0.95))
                            .cornerRadius(15)
                            .shadow(radius: 10)
                            .onTapGesture {
                                level = "L2"
                                show.toggle()
                            }
                            
                            ZStack {
                                VStack {
                                    Image(systemName: "3.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 50)
                                        .padding()
                                        .foregroundColor(Color("ColorGradient3"))
                                    
                                    
                                    Text("POZIOM TRUDNY")
                                        .multilineTextAlignment(.center)
                                        .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.05))
                                        .foregroundColor(Color("DarkGrayColor"))
                                        .padding(5)
                                    
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            //                            .background(Color("ColorGradient3").opacity(0.9))
                            .background(Color.white.opacity(0.95))
                            .cornerRadius(15)
                            .shadow(radius: 10)
                            .onTapGesture {
                                level = "L3"
                                show.toggle()
                            }
                            
                            ZStack {
                                VStack {
                                    Image(systemName: "4.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 50)
                                        .padding()
                                        .foregroundColor(Color("CelestialBlueColor"))
                                    
                                    
                                    Text("TRYB MIESZANY")
                                        .multilineTextAlignment(.center)
                                        .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.05))
                                    //                                        .foregroundColor(Color.white)
                                        .foregroundColor(Color("DarkGrayColor"))
                                        .padding(5)
                                    
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            //                            .background(Color("CelestialBlueColor").opacity(0.9))
                            .background(Color.white.opacity(0.95))
                            .cornerRadius(15)
                            .shadow(radius: 10)
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
    MathGamesView()
}
