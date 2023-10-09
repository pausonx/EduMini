//
//  AllMessages.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 09/10/2023.
//

import SwiftUI

struct AllMessages: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject private var MMViewModel = MainMessagesViewModel()
    @State var chatUser: AppUser?
    @State private var shouldNavigateToChatLogView = false

    private var chatLogViewModel = ChatLogViewModel(chatUser: nil)

    @available(iOS, deprecated: 16.0)
    var body: some View {
        ScrollView {
            Text("Chat")
                .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.1))
                .foregroundColor(Color.white)
                .textCase(.none)
                .padding()
                .shadow(radius: 2)

            ForEach(MMViewModel.recentMessages) { recent in
                Button {
                    let uid = FirebaseManager.shared.auth.currentUser?.uid == recent.fromId ? recent.toId : recent.fromId
                    self.chatUser = .init(data: [FirebaseConstants.name: recent.name, FirebaseConstants.nick: recent.nick, FirebaseConstants.uid: uid])
                    self.chatLogViewModel.chatUser = self.chatUser
                    self.chatLogViewModel.fetchMessages()
                    self.shouldNavigateToChatLogView = true
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: UIScreen.main.bounds.width * 0.1, weight: .light))
                            .foregroundColor(Color.gray.opacity(0.9))
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(recent.name)")
                                .font(.system(size: 16, weight: .bold))
                            
                            if recent.fromId == FirebaseManager.shared.auth.currentUser?.uid {
                                Text("Ty: \(recent.text)")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.leading)
                            } else {
                                Text(recent.text)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        
                        Spacer()

                        VStack {
                            Text(recent.timeAgo)
                                .font(.system(size: 14, weight: .medium))
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color(UIColor(.white.opacity(0.8))))
                    .foregroundColor(Color.black)
                }
            }
            .background(
                NavigationLink(destination: ChatLogView(CLViewModel: self.chatLogViewModel), isActive: self.$shouldNavigateToChatLogView) {
                    EmptyView()
                }
            )
        }
        .background(
            Image("profileBG")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
                .background(Color.clear)
        )
    }
}



struct AllMessages_Previews: PreviewProvider {
    static var previews: some View {
        AllMessages()
        
        AllMessages()
            .preferredColorScheme(.dark)
    }
}
