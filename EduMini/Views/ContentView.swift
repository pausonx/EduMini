//
//  ContentView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 07/08/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.isSignedIn {
                MainView()
                    .navigationBarHidden(true)
            } else {
                HelloPage()
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppViewModel())

    }
}
