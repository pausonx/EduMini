//
//  TextFieldName.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 07/08/2023.
//

import SwiftUI

struct TextFieldName: View {
    
    let name: String
    
    var body: some View {
        Text(name)
            .foregroundColor(.secondary)
            .frame(height: 15, alignment: .leading)
    }
}

struct TextFieldName_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldName(name: "")
    }
}
