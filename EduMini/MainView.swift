//
//  MainView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 07/08/2023.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 0
    @State private var shouldShowLogOutOptions = false
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ListView()
                .tabItem {
                    Label("Strona główna", systemImage: "house")
                }
                .tag(0)
            
            FlashcardsView()
                .tabItem {
                    Label("Fiszki", systemImage: "square.stack.fill")
                }
                .tag(1)
            
            ToDoView()
                .tabItem {
                    Label("ToDo", systemImage: "checklist")
                }
                .tag(2)
            
            ChatView()
                .tabItem {
                    Label("Chat", systemImage: "message.fill")
                }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Label("Profil", systemImage: "person.fill")
                }
                .tag(4)
        }
    }
}

struct ListView: View {
    var body: some View {
        NavigationView {
            ZStack {
                
                List {
                    NavigationLink(destination: InstructionView()) {
                        HStack {
                            Image(systemName: "book.fill")
                                .font(.system(size: 35, weight: .bold))
                                .foregroundColor(Color.accentColor)
                                .frame(width: 50, height: 50)
                            
                            Text("Instrukcja")
                                .font(.system(size: 18, weight: .light))
                        }
                    }
                    
                }
                .navigationBarTitle("Strona główna")
                .navigationBarTitleDisplayMode(.inline)
                .modifier(NavigationBarColorModifier(backgroundColor: UIColor(Color.accentColor), tintColor: UIColor.white))
            }
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
