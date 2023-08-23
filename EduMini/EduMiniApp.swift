//
//  EduMiniApp.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 07/08/2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct EduMiniApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject private var viewModel = AppViewModel()
    @StateObject private var settings = ParentalControlSettings(
         isActiveChat: false,
         isActiveEmail: false,
         isActiveAge: false
     )
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppViewModel())
                .environmentObject(settings)
        }
    }
}
