//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 12/31/24.
//

import SwiftUI

public struct TextInput: View {
    
    private struct UIConstants {
        static let horizontalPadding: CGFloat = 24
        static let verticalPadding: CGFloat = 10
        static let cornerRadius: CGFloat = 16
        static let shadowRadius: CGFloat = 5
        static let closeButtonOffset: CGFloat = -32
    }
    
    @Binding private var state: TextInputState
    private var validations: TextInputValidator = TextInputValidator()
    @FocusState private var isFocused: Bool
    
    public init(state: Binding<TextInputState>) {
        _state = state
    }
    
    public var body: some View {
        VStack {
            if state.reqSecureField {
                secureTextField
            } else {
                HStack(spacing: -16) {
                    customTextField
                    if state.showCloseButton {
                        closeButton
                            .opacity(isFocused ? 1 : 0)
                            .frame(alignment: .trailing)
                    }
                }
            }
        }
    }
    
    var customTextField: some View {
        TextField("", text: $state.text, prompt: Text(state.placeholder).foregroundColor(.white))
            .padding(.horizontal, UIConstants.horizontalPadding)
            .padding(.vertical, UIConstants.verticalPadding)
            .scaleEffect(state.scaleEffect && isFocused ? 1.05 : 1.0)
            .foregroundColor(state.textColor)
            .background(SpaceColors.blue50)
            .cornerRadius(UIConstants.cornerRadius)
            .focused($isFocused)
            .shadow(color: SpaceColors.black25, radius: 5)
            .textInputAutocapitalization(validations.autoCaptialization(for: state.type))
            .overlay(
                RoundedRectangle(cornerRadius: UIConstants.cornerRadius)
                    .stroke(state.strokeColor, lineWidth: 1)
            )
            .onChange(of: state.text) { newValue in
                if state.text.isEmpty || newValue.isEmpty {
                    state.previousText = ""
                    return
                }
                
                
                if validations.checkMaxLength(newValue, textFieldType: state.type) &&
                    validations.checkAllowedChar(newValue, textFieldType: state.type) {
                    state.text = newValue
                } else {
                    state.text = state.previousText
                }
                state.isValid = validations.checkStateValidations(text: newValue, textFieldType: state.type)
            }
            .padding(.leading, 16)
            .padding(.trailing, state.showCloseButton ? 16 : 0)
    }
    
    var secureTextField: some View {
        SecureField("", text: $state.text, prompt: Text(state.placeholder).foregroundColor(.white))
            .scaleEffect(state.scaleEffect && isFocused ? 1.05 : 1.0)
            .foregroundColor(state.textColor)
            .padding(.horizontal, UIConstants.horizontalPadding)
            .padding(.vertical, UIConstants.verticalPadding)
            .background(SpaceColors.blue50)
            .cornerRadius(UIConstants.cornerRadius)
            .focused($isFocused)
            .shadow(color: SpaceColors.black25, radius: 5)
            .textInputAutocapitalization(validations.autoCaptialization(for: state.type))
            .overlay(
                RoundedRectangle(cornerRadius: UIConstants.cornerRadius)
                    .stroke(state.strokeColor, lineWidth: 1)
            )
            .onChange(of: state.text) { newValue in
                if state.text.isEmpty || newValue.isEmpty {
                    state.previousText = ""
                    return
                }
                
                if validations.checkMaxLength(newValue, textFieldType: state.type) &&
                    validations.checkAllowedChar(newValue, textFieldType: state.type) {
                    state.text = newValue
                } else {
                    state.text = state.previousText
                }
                state.isValid = validations.checkStateValidations(text: newValue, textFieldType: state.type)
            }
            .padding(.leading, 16)
            .padding(.trailing, state.showCloseButton ? 16 : 0)
    }
    
    var closeButton: some View {
        Button(action: {
            state.previousText = ""
            state.text = ""
            print("Close Button Tapped", state.text)
        }) {
            Image(systemName: "xmark")
                .foregroundColor(.white)
        }
        .offset(x: -32)
    }
    
}


#Preview {
    VStack {
        Spacer()
        @State var username = TextInputState(text: "", type: .username, placeholder: "Enter Username", scaleEffect: true, showCloseButton: true, reqSecureField: false)
        TextInput(state: $username)
            .padding(.bottom, 32)
        
        @State var password = TextInputState(text: "", type: .password, placeholder: "Enter Password", scaleEffect: true, showCloseButton: true, reqSecureField: true)
        TextInput(state: $password)
        Spacer()
    }
    .background(Color.linearGradient)
}
