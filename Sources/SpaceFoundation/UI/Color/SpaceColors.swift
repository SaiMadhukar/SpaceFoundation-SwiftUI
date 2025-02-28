//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/8/24.
//

import Foundation
import SwiftUI

/*** MARK - Future Reference for loading from bundle
 
    fileprivate let defaultBundle: Bundle? = Bundle(url: Bundle.main.url(forResource: "Assets", withExtension: "bundle") ?? .applicationDirectory)
*/


public enum SpaceOpacity: CGFloat {
    
    // black
    case o10 = 0.1
    case o20 = 0.20
    case o25 = 0.25
    case o30 = 0.30
    case o40 = 0.40
    case o45 = 0.45
    case o50 = 0.50
    case o55 = 0.55
    case o60 = 0.60
    case o70 = 0.70
    case o75 = 0.75
    case o80 = 0.80
    case o90 = 0.90
    case o100 = 1.0
    
    public func color(_ color: Color) -> Color {
        color.opacity(self.rawValue)
    }
}

public enum loadColors: String {
    
    case white
    
    case blue10
    case blue50
    case blue90
    case blue100
    
    case background
    case secondary
    case primary
    case cream
    
    public var uiColor: UIColor? {
        UIColor(named: self.rawValue)
    }
    
    public var color: Color {
        Color(uiColor: uiColor ?? .clear)
    }
}

public struct SpaceColors {
    
    public static let black10: Color = SpaceOpacity.o10.color(.primary)
    public static let black25: Color = SpaceOpacity.o25.color(.primary)
    public static let black30: Color = SpaceOpacity.o30.color(.primary)
    public static let black40: Color = SpaceOpacity.o40.color(.primary)
    public static let black75: Color = SpaceOpacity.o75.color(.primary)
    
    public static let gray10: Color = SpaceOpacity.o10.color(.gray)
    public static let gray20: Color = SpaceOpacity.o20.color(.gray)
    public static let gray25: Color = SpaceOpacity.o25.color(.gray)
    public static let gray65: Color = SpaceOpacity.o60.color(.gray)
    
    public static let green45: Color = SpaceOpacity.o45.color(.green)
    public static let green55: Color = SpaceOpacity.o55.color(.green)
    public static let green75: Color = SpaceOpacity.o75.color(.green)
    
    public static let orange45: Color = SpaceOpacity.o45.color(.orange)
    public static let orange55: Color = SpaceOpacity.o55.color(.orange)
    public static let orange75: Color = SpaceOpacity.o75.color(.orange)
    
    public static let yellow55: Color = SpaceOpacity.o45.color(.yellow)
    public static let yellow75: Color = SpaceOpacity.o75.color(.yellow)
    public static let yellow90: Color = SpaceOpacity.o90.color(.yellow)
    
    
    public static let red45: Color = SpaceOpacity.o45.color(.red)
    public static let red55: Color = SpaceOpacity.o55.color(.red)
    
    
    public static let purple45: Color = SpaceOpacity.o45.color(.purple)
    public static let purple55: Color = SpaceOpacity.o55.color(.purple)
    
    public static let blue100: Color = loadColors.blue100.color
    public static let blue10: Color = loadColors.blue10.color
    public static let blue50: Color = loadColors.blue50.color
    public static let blue90: Color = loadColors.blue90.color
    
    public static let background: Color = loadColors.background.color
    public static let white: Color = loadColors.white.color
    public static let primary: Color = loadColors.primary.color
    public static let secondary: Color = loadColors.secondary.color
    public static let cream: Color = loadColors.cream.color
}


#Preview {
    VStack {
        Text("Login")
    }
    .frame(width: 400, height: 400)
    .background(SpaceColors.blue100)
}
