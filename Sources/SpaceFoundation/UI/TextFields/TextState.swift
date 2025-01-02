//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/28/24.
//

import SwiftUI


public class TextInputState: ObservableObject {
    @Published public var text: String
    @Published public var isValid: Bool? = nil
    
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
    let cornerRadius: CGFloat
    
    public init(text: String,
         type: FieldType = .default,
         placeholder: String,
         scaleEffect: Bool,
         showCloseButton: Bool = true,
         reqSecureField: Bool = false,
         cornerRadius: CGFloat = 16,
         border: Color = .black)
    {
        self.text = text
        self.type = type
        self.placeholder = placeholder
        self.scaleEffect = scaleEffect
        self.reqSecureField = reqSecureField
        self.cornerRadius = cornerRadius
        self.border = border
    }
}

enum TextError {
    
    case empty
    case unknownCharacters
    case invalidLength
    case invalid
}
