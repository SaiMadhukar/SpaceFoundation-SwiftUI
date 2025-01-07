//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/28/24.
//

import SwiftUI

extension Color {
    
    public static let linearGradient: LinearGradient = LinearGradient(
        gradient: Gradient(colors: [SpaceColors.green45, SpaceColors.orange45]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    public static let angularGradient: AngularGradient = AngularGradient(
        gradient: Gradient(colors: [SpaceColors.green45, SpaceColors.orange45]),
        center: .center
    )
    
    public var UiColor: UIColor {
        UIColor(self)
    }
}

extension Color {
    
    init(hex: String, opacity: Double = 1.0) {
        let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var hex: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&hex)
        
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

extension Color {
    
    public func uiColor() -> UIColor {
        let components = self.components()
        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }
    
    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {

           let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
           var hexNumber: UInt64 = 0
           var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

           let result = scanner.scanHexInt64(&hexNumber)
           if result {
               r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
               g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
               b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
               a = CGFloat(hexNumber & 0x000000ff) / 255
           }
           return (r, g, b, a)
       }
}


#Preview {
    ScrollView {
        VStack(alignment: .center) {
            Circle()
                .fill(Color(hex: "9CD0CC"))
                .frame(width: 250, height: 250)
            
            Circle()
                .fill(Color(hex: "2D82B5"))
                .frame(width: 250, height: 250)
        }
    }
}
