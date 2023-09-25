//
//  PINCheck.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 13/08/2023.
//

import SwiftUI

struct PINCheck: View {
    @State private var isPinCorrect = false
    @State private var showErrorMessage = false
    
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject private var NUViewModel = NewAppUsersModel()
    @EnvironmentObject var settings: ParentalControlSettings
    
    var body: some View {
        VStack {
            if isPinCorrect {
                ParentalControl()
            } else {
                Text("Podaj PIN")
                    .font(.system(size: 25, weight: .light))
                PinTextField(numOfFields: 4, isPinCorrect: $isPinCorrect, showErrorMessage: $showErrorMessage)
                    .onChange(of: isPinCorrect) { oldValue, newValue in
                        isPinCorrect = newValue
                    }
                if showErrorMessage {
                    Text("Podaj poprawny PIN")
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct PinTextField: View {
    
    let numOfFields: Int
    @Binding var isPinCorrect: Bool
    @Binding var showErrorMessage: Bool
    
    @State var enterValue: [String]
    @FocusState private var fieldFocus: Int?
    @State private var oldValue = ""
    
    init(numOfFields: Int, isPinCorrect: Binding<Bool>, showErrorMessage: Binding<Bool>){
        self.numOfFields = numOfFields
        self._isPinCorrect = isPinCorrect
        self._showErrorMessage = showErrorMessage
        self.enterValue = Array(repeating: "", count: numOfFields)
    }
    
    @ObservedObject private var NUViewModel = NewAppUsersModel()
    
    
    var body: some View {
        
        HStack{
            ForEach(0..<numOfFields, id: \.self) { index in
                TextField("", text: $enterValue[index], onEditingChanged: {
                    editing in
                    
                    if editing {
                        oldValue = enterValue[index]
                    }
                })
                .keyboardType(.numberPad)
                .frame(width: 68, height: 68)
                .font(.system(size: 25, weight: .light))
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(5)
                .multilineTextAlignment(.center)
                .focused($fieldFocus, equals: index)
                .tag(index)
                .onChange(of: enterValue[index]) { oldValue, newValue in
                    if enterValue[index].count > 1 {
                        let currValue = Array(enterValue[index])
                        
                        if currValue[0] == Character(oldValue) {
                            enterValue[index] = String(enterValue[index].suffix(1))
                        } else {
                            enterValue[index] = String(enterValue[index].prefix(1))
                        }
                    }
                    if !newValue.isEmpty {
                        if index == numOfFields - 1 {
                            fieldFocus = nil
                            
                            let pin = NUViewModel.appUser?.pin ?? ""
                            let enteredPin = enterValue.joined()
                            
                            if pin == enteredPin {
                                isPinCorrect = true
                            } else {
                                showErrorMessage = true
                            }
                        } else {
                            fieldFocus = (fieldFocus ?? 0) + 1
                        }
                    } else {
                        fieldFocus = (fieldFocus ?? 0) - 1
                    }
                    
                }
            }
        }
        
    }
}

struct PINCheck_Previews: PreviewProvider {
    static var previews: some View {
        PINCheck()
    }
}
