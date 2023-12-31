//
//  FlashcardsView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 13/08/2023.
//

import SwiftUI

struct FlashcardsView: View {
    @EnvironmentObject var flashcardVM: FlashcardViewModel
    @State var showAddView = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
//                    Background(title: "profileBG")
                    Image("profileBG")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .edgesIgnoringSafeArea(.all)
                        .background(Color.clear)
                    
                    VStack {
                        TabView {
                            ForEach(flashcardVM.flashcards) { items in
                                FlashcardView(topic: items.topic, question: items.question, answer: items.answer)
                                    .environmentObject(flashcardVM)
                            }
                        }
                        
                        HStack {
                            NavigationLink {
                                FlashcardListView()
                            } label: {
                                Image(systemName: "square.stack.fill")
                                    .font(.system(size: UIScreen.main.bounds.width * 0.1))
                                    .foregroundColor(Color("DarkBabyBlueColor"))
                            }
                            Spacer()
                            Button {
                                showAddView.toggle()
                            } label: {
                                Image(systemName: "plus.app.fill")
                                    .font(.system(size: UIScreen.main.bounds.width * 0.1))
                                    .foregroundColor(Color("DarkBabyBlueColor"))
                            }
                        }
                        .padding()
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .onAppear {
                        flashcardVM.loadFlashcardData()
                    }
                    .sheet(isPresented: $showAddView){
                        AddNewCardView(showAddView: $showAddView)
                            .environmentObject(flashcardVM)
                            .presentationDetents([.fraction(0.5)])
                            .presentationDragIndicator(.visible)
                    }
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
    }
}
