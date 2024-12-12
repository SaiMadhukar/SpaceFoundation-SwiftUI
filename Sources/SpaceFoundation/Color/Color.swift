//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/28/24.
//

import SwiftUI

extension Color {
    
    static let linearGradient: LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color.green.opacity(0.45), Color.orange.opacity(0.45)]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let angularGradient: AngularGradient = AngularGradient(
        gradient: Gradient(colors: [Color.green.opacity(0.45), Color.orange.opacity(0.45)]),
        center: .center
    )
    
    var UiColor: UIColor {
        UIColor(self)
    }
}
