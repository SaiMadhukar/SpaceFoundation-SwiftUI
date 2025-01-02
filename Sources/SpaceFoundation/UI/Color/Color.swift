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
