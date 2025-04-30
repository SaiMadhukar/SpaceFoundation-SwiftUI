//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/16/25.
//

import Foundation
import SwiftUI

public struct InputField: View {
    
    private struct UIConstants {
        static let horizontalPadding: CGFloat = 24
        static let verticalPadding: CGFloat = 12
        static let cornerRadius: CGFloat = 16
        static let shadowRadius: CGFloat = 5
        static let closeButtonOffset: CGFloat = -32
        static let labelOffset: CGFloat = -25
        static let fieldHeight: CGFloat = 56
    }
    
    @StateObject private var state: TextInputState
    private var validations: TextInputValidator = TextInputValidator()
    @FocusState private var isFocused: Bool
    
    public init(state: TextInputState) {
        _state = StateObject(wrappedValue: state)
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .leading) {
                SpaceLabel(title: state.placeholder, configuration: .secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .offset(y: isFocused || state.text.count > 0 ? UIConstants.labelOffset : 0)
                    .animation(.spring(response: 0.2, dampingFraction: 0.7), value: isFocused)
                    .animation(.spring(response: 0.2, dampingFraction: 0.7), value: state.text)
                
                VStack(spacing: 0) {
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
        }
        .frame(height: UIConstants.fieldHeight)
        .padding(.vertical, 8)
    }
    
    var customTextField: some View {
        TextField("", text: $state.text)
            .padding(.horizontal, UIConstants.horizontalPadding)
            .padding(.vertical, UIConstants.verticalPadding)
            .scaleEffect(state.scaleEffect && isFocused ? 1.02 : 1.0)
            .foregroundColor(state.font.fontColor)
            .font(state.font.font)
            .autocorrectionDisabled()
            .focused($isFocused)
            .shadow(color: SpaceColors.black25, radius: 5)
            .textInputAutocapitalization(validations.autoCaptialization(for: state.type))
            .overlay(alignment: .bottom, content: {
                VStack {
                    Divider()
                        .frame(minHeight: 2)
                        .background(state.strokeColor)
                }
                .padding(.horizontal, 16)
            })
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
        SecureField("", text: $state.text)
            .scaleEffect(state.scaleEffect && isFocused ? 1.02 : 1.0)
            .foregroundColor(state.font.fontColor)
            .padding(.horizontal, UIConstants.horizontalPadding)
            .padding(.vertical, UIConstants.verticalPadding)
            .cornerRadius(UIConstants.cornerRadius)
            .autocorrectionDisabled()
            .focused($isFocused)
            .shadow(color: SpaceColors.black25, radius: 5)
            .textContentType(state.type == .newPassword ? .newPassword : .password)
            .textInputAutocapitalization(validations.autoCaptialization(for: state.type))
            .overlay(alignment: .bottom, content: {
                VStack {
                    Divider()
                        .frame(minHeight: 2)
                        .background(state.strokeColor)
                }
                .padding(.horizontal, 16)
            })
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
         //   print("Close Button Tapped", state.text)
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
        InputField(state: username)
            .padding(.bottom, 32)
        
        @State var password = TextInputState(text: "", type: .password, placeholder: "Password", scaleEffect: true, showCloseButton: true, reqSecureField: true)
        InputField(state: password)
        Spacer()
    }
    .background(Color.linearGradient)
}

