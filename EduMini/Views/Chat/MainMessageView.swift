//
//  MainMessageView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 09/10/2023.
//

import SwiftUI

struct MainMessageView: View {

    @Environment(\.colorScheme) var colorScheme
    @State var shouldNavigateToChatLogView = false
    @State var chatUser: AppUser?
    @State var shouldShowNewMessageScreen = false
    
    @State private var isChatLogViewPresented = false
    
    @available(iOS, deprecated: 16.0)
    var body: some View {
        NavigationView {
            VStack {
                AllMessages()
            }
            .navigationBarHidden(true)
            .overlay(NewMessageButton, alignment: .bottom)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .background(Color.white)
        .sheet(isPresented: $shouldShowNewMessageScreen) {
            NewMessageUsers(didSelectNewUser: { user in
                self.chatUser = user
                self.shouldNavigateToChatLogView = true
            })
        }
        .background(
            NavigationLink(
                destination: ChatLogView(CLViewModel: ChatLogViewModel(chatUser: chatUser)),
                isActive: $shouldNavigateToChatLogView
            ) {
                EmptyView()
            }
            .hidden()
        )
    }
    
    private var NewMessageButton: some View {
        Button {
            isChatLogViewPresented = true
            shouldShowNewMessageScreen.toggle()
        } label: {
            HStack {
                Spacer()
                Text("Nowa wiadomość")
                    .font(.system(size: 16, weight: .bold))
                    .padding()
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width * 0.85)
            .foregroundColor(.white)
            .background(Color("BabyBlueColor"))
            .cornerRadius(10)
            .padding(.bottom, UIScreen.main.bounds.height * 0.03)
            .shadow(radius: 15)
        }
    }
}


struct MainMessageView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessageView()
        
        MainMessageView()
            .preferredColorScheme(.dark)
    }
}
