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
                            .presentationDetents([.fraction(0.45)])
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

struct FlashcardView: View {
    @EnvironmentObject var flashcardVM: FlashcardViewModel

    var topic = ""
    var question = ""
    var answer = ""
    @State var fliping = false
    @State var shouldDisapper = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color(.white))
                .shadow(radius: 10)
                .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.5)
                .rotation3DEffect(.degrees(fliping ? 180 : 0),axis: (x: 0.0, y: 1.0, z: 0.0))


            VStack(alignment: .leading){
                if fliping {
                    Text(topic)
                        .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.07))
                        .foregroundColor(.black)
                    
                    Text(answer)
                        .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.06))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.4)
                } else {
                    Text(topic)
                        .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.07))
                        .foregroundColor(.black)
                    
                    Text(question)
                        .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.06))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.4)
                }
                
            }
            .opacity(shouldDisapper ? 0 : 1)
            
            
        }
        .onTapGesture {
            shouldDisapper.toggle()
            withAnimation(.easeInOut(duration: 0.5)) {
                fliping.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    shouldDisapper = false
                }
            }
        }
    }
}


struct FlashcardListView: View {
    @State var selectedQuestion: Flashcard?
    @State var newTopic = ""
    @State var newQuestion = ""
    @State var newAnswer = ""
    @EnvironmentObject var flashcardVM: FlashcardViewModel
    
    @State private var showHelpDelete = false
    @State private var showHelpUpdate = false

    
    var body: some View {
        List {
            Section {
                ForEach(flashcardVM.flashcards) {
                    items in
                    Button {
                        self.selectedQuestion = items
                        self.newTopic = items.topic
                        self.newQuestion = items.question
                        self.newAnswer = items.answer
                    } label: {
                        VStack(alignment: .leading){
                            Text(items.topic).bold()
                                .foregroundColor(Color.black)
                            Text(items.question)
                                .foregroundColor(Color.black)
                            Text(items.answer)
                                .foregroundColor(Color.gray)
                                .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.03))
                        }
                        .frame(height: 50)
                    }
                }
                .onDelete(perform: flashcardVM.deleteFlashcard)
            } header: {
                Text("Twoje fiszki")
                    .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.1))
                    .foregroundColor(Color.white)
                    .textCase(.none)
                    .shadow(radius: 2)
                
            }
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
        .sheet(item: $selectedQuestion) { items in
            UpdateCardView(selectedQuestion: items, newTopic: $newTopic, newQuestion: $newQuestion, newAnswer: $newAnswer)
                .presentationDetents([.fraction(0.45)])
                .presentationDragIndicator(.visible)
        }
        .navigationBarBackButtonHidden()
        
        
        HStack {
            Button(action: {
                showHelpUpdate = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    showHelpUpdate = false
                }
            }) {
                Image(systemName: "square.and.pencil")
                    .font(.system(size: UIScreen.main.bounds.width * 0.1, weight: .medium))
                    .foregroundColor(Color("DarkBabyBlueColor"))
            }
            Spacer()
            HStack {
                Button(action: {
                    showHelpDelete = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showHelpDelete = false
                    }
                }) {
                    Image(systemName: "trash.square.fill")
                        .font(.system(size: UIScreen.main.bounds.width * 0.1, weight: .medium))
                        .foregroundColor(Color("DarkBabyBlueColor"))
                }
            }
        }
        .padding()
        .overlay(
            Group {
                if showHelpUpdate {
                    Text("Aby edytować zadanie, wybierz je i wpisz nowe dane")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("DarkBabyBlueColor").opacity(0.9))
                        .cornerRadius(10)
                        .transition(.opacity)
                }
            }
        )
        .overlay(
            Group {
                if showHelpDelete {
                    Text("Aby usunąć zadanie, przesuń od prawej do lewej!")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("DarkBabyBlueColor").opacity(0.9))
                        .cornerRadius(10)
                        .transition(.opacity)
                }
            }
        )
    }
}
