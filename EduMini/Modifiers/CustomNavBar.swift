//
//  CustomNavBar.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 13/08/2023.
//

import Foundation
import SwiftUI

struct NavigationBarColorModifier: ViewModifier {
    var backgroundColor: UIColor?
    var tintColor: UIColor?
    
    init(backgroundColor: UIColor?, tintColor: UIColor?) {
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: tintColor ?? UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: tintColor ?? UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                UINavigationBar.appearance().backgroundColor = backgroundColor
                UINavigationBar.appearance().tintColor = tintColor
            }
            .onDisappear {
                UINavigationBar.appearance().backgroundColor = nil
                UINavigationBar.appearance().tintColor = nil
            }
    }
}
