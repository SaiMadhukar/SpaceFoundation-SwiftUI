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
    
    @StateObject private var state: TextInputState
    private var validations: TextInputValidator = TextInputValidator()
    @FocusState private var isFocused: Bool
    
    public init(state: TextInputState) {
        _state = StateObject(wrappedValue: state)
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                if state.reqSecureField {
                    secureTextField
                        .scaleEffect(isFocused ? 1.0 : 0.96)
                } else {
                    HStack(spacing: -16) {
                        customTextField
                            .scaleEffect(isFocused ? 1.0 : 0.96)
                        if state.showCloseButton {
                            closeButton
                                .opacity(isFocused ? 1 : 0)
                                .frame(alignment: .trailing)
                        }
                    }
                }
            }
            
            VStack(alignment: .leading) {
                Text(state.placeholder)
                    .spaceFontStyle(category: .subheading, color: SpaceColors.secondary)
                    .frame(alignment: .leading)
                    .padding(.horizontal, 16)
            }
            .background(SpaceColors.white)
            .scaleEffect( !isFocused && state.text.isEmpty() ? 1 : 0.85)
            .offset(x: 20,
                    y: !isFocused && state.text.isEmpty() ? 0 : -24)
            .onTapGesture {
                isFocused = true
            }
        }
        .frame(height: 70)
    }
    
    var customTextField: some View {
        TextField("", text: $state.text)
            .padding(.horizontal, UIConstants.horizontalPadding)
            .padding(.vertical, UIConstants.verticalPadding)
            .scaleEffect(state.scaleEffect && isFocused ? 1.05 : 1.0)
            .foregroundColor(state.font.fontColor)
            .font(state.font.font)
            .autocorrectionDisabled()
            .background(state.backgroundColor)
            .cornerRadius(UIConstants.cornerRadius)
            .focused($isFocused)
            .textInputAutocapitalization(validations.autoCaptialization(for: state.type))
            .overlay(
                RoundedRectangle(cornerRadius: UIConstants.cornerRadius)
                    .stroke(state.strokeColor, lineWidth: 2)
            )
            .onChange(of: state.text) { newValue in
                print("New Value", newValue)
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
        SecureField("", text: $state.text)
            .scaleEffect(state.scaleEffect && isFocused ? 1.05 : 1.0)
            .foregroundColor(state.font.fontColor)
            .font(state.font.font)
            .padding(.horizontal, UIConstants.horizontalPadding)
            .padding(.vertical, UIConstants.verticalPadding)
            .background(state.backgroundColor)
            .cornerRadius(UIConstants.cornerRadius)
            .autocorrectionDisabled()
            .focused($isFocused)
            .shadow(color: SpaceColors.black25, radius: 5)
            .textContentType(state.type == .newPassword ? .newPassword : .password)
            .textInputAutocapitalization(validations.autoCaptialization(for: state.type))
            .overlay(
                RoundedRectangle(cornerRadius: UIConstants.cornerRadius)
                    .stroke(state.strokeColor, lineWidth: 2)
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
            self.state.previousText = ""
            self.state.text = ""
            self.isFocused = false
        }) {
            Image(systemName: "xmark")
                .foregroundColor(SpaceColors.primary)
        }
        .offset(x: -32)
    }
    
}


#Preview {
    VStack {
        Spacer()
        @State var username = TextInputState(text: "", type: .username, placeholder: "Username", scaleEffect: true, showCloseButton: true, reqSecureField: false)
        TextInput(state: username)
            .padding(.bottom, 32)
        
        @State var password = TextInputState(text: "", type: .password, placeholder: "Password", scaleEffect: true, showCloseButton: true, reqSecureField: true)
        TextInput(state: password)
        Spacer()
    }
    .background(Color.white)
}
