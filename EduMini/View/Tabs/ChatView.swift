//
//  ChatView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 13/08/2023.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Tu jest zawartość strony chatu")
                // Dodaj inne elementy
            }
            .navigationBarTitle("Chat")
        }
        .tabItem {
            Label("Chat", systemImage: "message.fill")
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
