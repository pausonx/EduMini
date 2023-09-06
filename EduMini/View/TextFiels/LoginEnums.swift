//
//  LoginEnums.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 07/08/2023.
//

import Foundation

enum Hint: String {
    case email = "Podaj adres email w formacie abc@xyz.dd"
    case password = "Długość hasła nie może być krótsza niż 8 znaków i musi zaczynać się literą"
    case age = "Wiek nie może być mniejszy niż 1 i większy niż 99"
    case pin = "PIN może zawierać tylko cyfry i mieć długość 4 znaków"
}

enum Regex: String {
    case login = "^[a-zA-Z][a-zA-Z0-9]{2,49}$"
    case name = "^[a-zA-Z]{2,49}$"
    case email = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,49}$"
    case password = "^[a-zA-Z][a-zA-Z0-9]{7,11}$"
    case age = "^[0-9]{1,2}$"
    case pin = "^[0-9]{4}$"
}
