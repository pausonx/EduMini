//
//  ChatLogView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 09/10/2023.
//

import SwiftUI

struct ChatLogView: View {
    
    @ObservedObject var CLViewModel: ChatLogViewModel
    
    var body: some View {
        ZStack {
            messagesView
            Text(CLViewModel.errorMessage)
        }
        .navigationTitle(CLViewModel.chatUser?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    static let emptyScrollToString = "Empty"
    
    private var messagesView: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                VStack {
                    ForEach(Array(CLViewModel.chatMessages.enumerated()), id: \.offset) {index, message in
                        MessageView(message: message)
                    }
                    
                    HStack{ Spacer() }
                        .id(ChatLogView.emptyScrollToString)
                }
                .onReceive(CLViewModel.$count) { _ in
                    withAnimation(.easeOut(duration: 0.5)) {
                        scrollViewProxy.scrollTo(ChatLogView.emptyScrollToString, anchor: .bottom)
                    }
                }
            }
        }
        .background(Color(UIColor(.gray.opacity(0.1))))
        .safeAreaInset(edge: .bottom, content: {
            chatBottomBar
                .background(Color(.systemBackground))
        })
    }
    
    private var chatBottomBar: some View {
            HStack(spacing: 16) {
                ZStack {
                    HStack {
                        Text("Aa")
                            .foregroundColor(Color(.gray))
                            .font(.system(size: 20))
                            .padding(.leading, 5)
                            .padding(.top, -4)
                        Spacer()
                    }
                    TextEditor(text: $CLViewModel.chatText)
                        .opacity(CLViewModel.chatText.isEmpty ? 0.5 : 1)
                }
                .frame(height: 40)
                
                Button {
                    CLViewModel.handleSend(text: CLViewModel.chatText)
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color("BabyBlueColor"))
                .cornerRadius(25)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessageView()
    }
}
