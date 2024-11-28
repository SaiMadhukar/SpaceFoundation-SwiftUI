//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/21/24.
//

import Foundation
import SwiftUICore

extension View {
    
    func textStyle(_ textStyle: FontCategory, weight: Font.Weight = .regular, color: Color = .clear) -> some View {
        self.modifier(FontStyle(category: textStyle, weight: weight, customColor: color))
    }
}
