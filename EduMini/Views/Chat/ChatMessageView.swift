//
//  ChatMessageView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 09/10/2023.
//

import SwiftUI

struct ChatMessageView: View {
    @Binding var shouldNavigateToChatLogView: Bool
    @State var chatUser: AppUser?
    @State private var isChatLogViewPresented = false
    
    var body: some View {
        Button(action: {
            isChatLogViewPresented = true
        }) {
            Text("ChatMessageView")
        }
        .sheet(isPresented: $isChatLogViewPresented) {
            NavigationView {
                ChatLogView(CLViewModel: ChatLogViewModel(chatUser: chatUser))
                    .navigationBarHidden(true)
            }
        }
    }
}


struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageView(shouldNavigateToChatLogView: .constant(true))
    }
}
