//
//  NewMessageUsers.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 09/10/2023.
//

import SwiftUI

struct NewMessageUsers: View {
    
    @ObservedObject private var NMViewModel = UserProfileViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    let didSelectNewUser: (AppUser) -> ()
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text(NMViewModel.errorMessage)
                
                ForEach(NMViewModel.users) { user in
                    if let userAge = Int(user.age), userAge > 6 {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            didSelectNewUser(user)
                        } label: {
                            HStack(spacing: 10) {
                                Text(user.nick)
                                    .foregroundColor(Color(.label))
                                    .font(.system(size: 20))
                                Spacer()
                            }.padding(.horizontal)
                        }
                        Divider()
                    }
                }
            }.navigationTitle("Nowa wiadomość")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Anuluj")
                        }
                    }
                }
        }
    }
}
