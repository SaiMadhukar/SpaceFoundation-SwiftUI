//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/28/24.
//

import SwiftUI

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
    let textColor: Color = .white
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

enum TextError {
    
    case empty
    case unknownCharacters
    case invalidLength
    case invalid
}
