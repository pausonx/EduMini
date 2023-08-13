//
//  ToDoView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 13/08/2023.
//

import SwiftUI

struct ToDoView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Tu jest zawartość strony ToDo")
                // Dodaj inne elementy
            }
            .navigationBarTitle("Do zrobienia")
        }
        .tabItem {
            Label("ToDo", systemImage: "checklist")
        }
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}
