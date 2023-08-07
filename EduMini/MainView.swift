//
//  MainView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 07/08/2023.
//

import SwiftUI

struct MainView: View {
    @State var shouldShowLogOutOptions = false
    @EnvironmentObject var viewModel: AppViewModel

    
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button {
                shouldShowLogOutOptions.toggle()
            } label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("AccentColor"))
            }
        }
        .padding()
        .actionSheet(isPresented: $shouldShowLogOutOptions) {
            .init(title: Text("Sign out"), message: Text("Are you sure?"), buttons: [
                .destructive(Text("Sign Out"), action: {
                    viewModel.signOut()
                }),
                .cancel()
            ])
        }
        
    }
   
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
