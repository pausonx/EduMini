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
                .foregroundColor(.secondary)
                .padding(5)
                .frame(height: hint.isEmpty ? 0 : 70)
                .multilineTextAlignment(.leading)
                .background(Color.white.opacity(0.5))
                .cornerRadius(10)
        }
}

struct TextFieldHintRed: View {
    let hint: String
        var body: some View {
            return Text(hint)
                .font(.system(size: 12, weight: .light))
                .foregroundColor(.red)
                .frame(height: hint.isEmpty ? 0 : 25)
                .multilineTextAlignment(.leading)
        }
}

struct TextFieldHint_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldHint(hint: "Test")
    }
}
