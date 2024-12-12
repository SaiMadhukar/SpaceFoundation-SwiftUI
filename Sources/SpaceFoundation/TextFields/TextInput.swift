//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/23/24.
//

import Foundation
import SwiftUI
import Combine

public struct TextInput: View {
    
    private var validator: TextInputValidator = TextInputValidator()
    @StateObject private var state: TextInputState
    @FocusState private var isFocused: Bool
    
    public init(state: TextInputState) {
        _state = StateObject(wrappedValue: state)
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(state.title)
                .textStyle(.body)
                .padding(.horizontal, 16)
            HStack {
                if state.reqSecureField {
                    secureTextField
                } else {
                    customTextField
                    closeButton
                }
            }
            .padding(.horizontal, 16)
            .background(content: {
                Capsule()
                    .fill(.black.opacity(0.20),
                          strokeColor: state.strokeColor,
                          stroke: .init(lineWidth: 2))
                    .scaleEffect(state.scaleEffect && isFocused ? 1.0 : 0.95)
            })
            .frame(height: 50)
        }
    }
    
    private var customTextField: some View {
        VStack(alignment: .leading) {
            TextField("",
                      text: $state.text,
                      prompt: Text(state.placeholder).foregroundColor(state.textColor.opacity(0.75)))
                .focused($isFocused)
                .padding()
                .foregroundColor(state.textColor)
                .scaleEffect(state.scaleEffect && isFocused ? 1.0 : 0.95)
                .onChange(of: state.text, perform: { newValue in
                    if validator.checkMaxLength(newValue, textFieldType: state.type) {
                        if validator.check(newValue, textFieldType: state.type) {
                            state.previousText = newValue
                        } else {
                            state.text = state.previousText
                        }
                    } else {
                        state.text = state.previousText
                    }
                    state.isValid = validator.checkValidity(text: state.text, textFieldType: state.type)
                })
        }
    }
    
    private var secureTextField: some View {
        VStack(alignment: .leading) {
            SecureField(state.placeholder, text: $state.text)
                .focused($isFocused)
                .padding()
                .foregroundColor(state.textColor)
                .scaleEffect(state.scaleEffect && isFocused ? 1.0 : 0.95)
                .onChange(of: state.text, perform: { newValue in
                    if validator.checkMaxLength(newValue, textFieldType: state.type) {
                        if validator.check(newValue, textFieldType: state.type) {
                            state.previousText = newValue
                        } else {
                            state.text = state.previousText
                        }
                    } else {
                        state.text = state.previousText
                    }
                    state.isValid = validator.checkValidity(text: state.text, textFieldType: state.type)
                })
        }
    }
    
    var closeButton: some View {
        Button("", systemImage: "xmark") {
            state.text = ""
            isFocused = false
        }
        .opacity(isFocused ? 1 : 0)
        .tint(.white.opacity(0.50))
        .frame(width: 32, height: 32, alignment: .trailing)
    }
}


#Preview {
    
    VStack {
        Spacer()
        let usernameState: TextInputState = .init(text: "", title: "Username", type: .username, placeholder: "Enter username", scaleEffect: false, showCloaseButton: true, reqSecureField: false)
        
        TextInput(state: usernameState)
        
        Spacer()
    }
    .background(Color.linearGradient)
}
