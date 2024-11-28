//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/23/24.
//

import Foundation
import SwiftUI
import Combine

public class TextInputState: ObservableObject {
    @Published var text: String
    @Published var isValid: Bool? = nil
    
    var strokeColor: Color {
        if text.isEmpty || isValid == nil {
            return Color.black.opacity(0.25)
        } else {
            return (isValid ?? false) ? Color.green.opacity(0.55) : Color.red.opacity(0.70)
        }
    }
    
    var scaleEffect: Bool
    var previousText: String = ""
    let type: FieldType
    let placeholder: String
    let showCloseButton: Bool = true
    let reqSecureField: Bool
    let border: Color
    let title: String
    
    public init(text: String,
         title: String,
         type: FieldType = .default,
         placeholder: String,
         scaleEffect: Bool,
         showCloaseButton: Bool = true,
         reqSecureField: Bool = false,
         border: Color = .black)
    {
        self.text = text
        self.title = title
        self.type = type
        self.placeholder = placeholder
        self.scaleEffect = scaleEffect
        self.reqSecureField = reqSecureField
        self.border = border
    }
}

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
                .textStyle(.headingSmall)
                .padding(.horizontal, 16)
            HStack {
                if state.reqSecureField {
                    secureTextField
                } else {
                    customTextField
                    closeButton
                }
            }
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
                      prompt: Text(state.placeholder).foregroundColor(.white.opacity(0.75)))
                .focused($isFocused)
                .padding()
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
        .tint(.gray.opacity(0.50))
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
