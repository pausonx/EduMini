//
//  EduMiniApp.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 07/08/2023.
//

import SwiftUI
import FirebaseCore

@main
struct EduMiniApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject private var viewModel = AppViewModel()
    @StateObject private var settings = ParentalControlSettings(
         isActiveEmail: false,
         isActiveAge: false
     )
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(settings) 
        }
    }
}
