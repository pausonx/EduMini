//
//  TextFieldHint.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 07/08/2023.
//

import SwiftUI

struct TextFieldHint: View {
    let hint: String
        var body: some View {
            return Text(hint)
                .font(.system(size: 15, weight: .light))
                .foregroundColor(.white)
                .frame(height: hint.isEmpty ? 0 : 40)
                .multilineTextAlignment(.leading)
        }
}

struct TextFieldHint_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldHint(hint: "Test")
    }
}
