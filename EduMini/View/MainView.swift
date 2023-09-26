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
            
            GamesView()
                .tabItem {
                    Label("Gry edukacyjne", systemImage: "gamecontroller.fill")
                }
                .tag(1)
            
            ChatView()
                .tabItem {
                    Label("Chat", systemImage: "message.fill")
                }
                .tag(2)
        }
        .font(Font.custom("BalsamiqSans-Regular", size: 20))
    }
}

struct ListView: View {
    @State var shouldShowLogOutOptions = false
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject private var NUViewModel = NewAppUsersModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background") // Ustawienie obrazu jako tło
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                    .background(Color.clear)
                
                ScrollView {
                    VStack (spacing: 15) {
                        Spacer()
                        HStack {
                            let name = NUViewModel.appUser?.name ?? "Test"
                        
                            Spacer()
                            HStack {
                                Text("Hej, ")
                                    .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.05)) +
                                Text(name)
                                    .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.05))
                            }
                            .padding(.top, UIScreen.main.bounds.width * 0.1)
                            
                            
                            NavigationLink(destination: ProfileView()) {
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 50, weight: .bold))
                                    .foregroundColor(Color.secondary)
                                    .padding(.horizontal, 15)
                                    .padding(.top, UIScreen.main.bounds.width * 0.1)
                            }
                           
                        }
                        NavigationLink(destination: InstructionView()) {
                            ZStack {
                                HStack {
                                    Image(systemName: "book.fill")
                                        .font(.system(size: 35, weight: .bold))
                                        .foregroundColor(Color.white)
                                        .frame(width: 50, height: 50)
                                    
                                    Text("Instrukcja")
                                        .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.08))
                                        .foregroundColor(Color.white)
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.15)
                            .background(Color("BrightPinkColor"))
                            .cornerRadius(25)
                            .shadow(radius: 10)
                        }
                        .navigationBarBackButtonHidden(true)

                        
                        HStack {
                            NavigationLink(destination: FlashcardsView()) {
                                ZStack {
                                    VStack {
                                        Image(systemName: "square.stack.fill")
                                            .font(.system(size: 35, weight: .bold))
                                            .foregroundColor(Color.white)
                                            .frame(width: 50, height: 50)
                                            .padding(5)
                                        
                                        
                                        Text("Fiszki")
                                            .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.07))
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
                            .navigationBarBackButtonHidden(true)

                            
                            NavigationLink(destination: ToDoView()) {
                                ZStack {
                                    VStack {
                                        Image(systemName: "checklist")
                                            .font(.system(size: 35, weight: .bold))
                                            .foregroundColor(Color.white)
                                            .frame(width: 50, height: 50)
                                            .padding(5)
                                        
                                        
                                        Text("Do zrobienia")
                                            .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.07))
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
                            .navigationBarBackButtonHidden(true)

                        }
                        
                        
                        
                        HStack {
                            NavigationLink(destination: ProfileView()) {
                                ZStack {
                                    VStack {
                                        Image(systemName: "person.fill")
                                            .font(.system(size: 35, weight: .bold))
                                            .foregroundColor(Color.white)
                                            .frame(width: 50, height: 50)
                                            .padding(5)
                                        
                                        
                                        Text("Profil")
                                            .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.08))
                                            .foregroundColor(Color.white)
                                            .padding(5)
                                        
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2)
                                .background(Color("SunglowColor"))
                                .cornerRadius(25)
                                .shadow(radius: 10)
                                .padding(10)
                                
                            }
                            .navigationBarBackButtonHidden(true)

                            
                            Button {
                                shouldShowLogOutOptions.toggle()
                            } label: {
                                VStack {
                                    Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                                        .font(.system(size: 35, weight: .bold))
                                        .foregroundColor(Color.white)
                                    
                                    Text("Wyloguj się")
                                        .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.06))
                                        .foregroundColor(Color.white)
                                        .padding(5)
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2)
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2)
                            .background(Color("DarkBabyBlueColor"))
                            .cornerRadius(25)
                            .shadow(radius: 10)
                        .padding(10)
                        }
                        
                    }
                    
                }
                .actionSheet(isPresented: $shouldShowLogOutOptions) {
                    .init(title: Text("Wylogowywanie"), message: Text("Czy na pewno chcesz to zrobić?"), buttons: [
                        .destructive(Text("Wyloguj się"), action: {
                            viewModel.signOut()
                        }),
                        .cancel(Text("Anuluj"))
                    ])
                }
            .navigationBarHidden(true)
            }
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
