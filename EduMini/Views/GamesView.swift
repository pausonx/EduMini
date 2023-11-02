//
//  GamesView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 07/09/2023.
//

import SwiftUI

struct GamesView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Background(title: "hellopagebg")
                
                ScrollView {
                    VStack (spacing: 15) {
                        Spacer()
                        HStack {
                            Text("Gry edukacyjne")
                                .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.08))
                                .padding(.top,UIScreen.main.bounds.height * 0.05)
                                .padding(.horizontal, UIScreen.main.bounds.height * 0.03)
                                .foregroundColor(Color.white)
                                .shadow(radius: 2)
                            
                            Spacer()
                        }
                        
                        NavigationLink(destination: EmptyView()) {
                            ZStack {
                                HStack {
                                    Image(systemName: "medal.fill")
                                        .font(.system(size: 35, weight: .bold))
                                        .foregroundColor(Color.white)
                                        .frame(width: 50, height: 50)
                                    
                                    Text("Ranking")
                                        .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.08))
                                        .foregroundColor(Color.white)
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.15)
                            .background(Color("OrangeColor"))
                            .cornerRadius(25)
                            .shadow(radius: 10)
                        }
                        
                        HStack {
                            NavigationLink(destination: MathGamesView()) {
                                ZStack {
                                    VStack {
                                        Image(systemName: "puzzlepiece.fill")
                                            .font(.system(size: 35, weight: .bold))
                                            .foregroundColor(Color.white)
                                            .frame(width: 50, height: 50)
                                            .padding(5)
                                        
                                        
                                        Text("Matematyka")
                                            .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.05))
                                            .foregroundColor(Color.white)
                                            .padding(5)
                                        
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2)
                                .background(Color("CelestialBlueColor"))
                                .cornerRadius(25)
                                .shadow(radius: 10)
                                .padding(10)
                                
                            }
                            
                            NavigationLink(destination: PolishGamesView()) {
                                ZStack {
                                    VStack {
                                        Image(systemName: "textformat.abc.dottedunderline")
                                            .font(.system(size: 35, weight: .bold))
                                            .foregroundColor(Color.white)
                                            .frame(width: 50, height: 50)
                                            .padding(5)
                                        
                                        
                                        Text("Język polski")
                                            .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.05))
                                            .foregroundColor(Color.white)
                                            .padding(5)
                                        
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2)
                                .background(Color("BrightPinkColor"))
                                .cornerRadius(25)
                                .shadow(radius: 10)
                                .padding(10)
                                
                                
                            }
                            
                        }
                        
                        HStack {
                            NavigationLink(destination: EnglishGamesView()) {
                                ZStack {
                                    VStack {
                                        Image(systemName: "brain.head.profile")
                                            .font(.system(size: 35, weight: .bold))
                                            .foregroundColor(Color.white)
                                            .frame(width: 50, height: 50)
                                            .padding(5)
                                        
                                        
                                        Text("Język angielski")
                                            .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.05))
                                            .foregroundColor(Color.white)
                                            .padding(5)
                                        
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2)
                                .background(Color("EmeraldColor"))
                                .cornerRadius(25)
                                .shadow(radius: 10)
                                .padding(10)
                                
                            }
                        }
                        
                    }
                    .navigationBarHidden(true)
                    
                }
            }
            
        }
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        GamesView()
    }
}
