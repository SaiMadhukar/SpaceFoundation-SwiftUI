//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 12/17/24.
//

import SwiftUI
import SwiftUICore

public enum SpaceGradient: String {
    
    case blueLightRadial
    case goldLightRadial
    case purpleGoldRadial
    case greenOrangeLinear
    case purpleBlueLinear
    case blueBlackLinear
    case creamLinear
    
    var colorMix: [Color] {
        switch self {
        case .blueLightRadial:
            return [Color(hex: "9CD0CC"), Color(hex: "2D82B5")]
        case .goldLightRadial:
            return [Color(hex: "EAF079"), Color(hex: "E6CB5F"), Color(hex: "F0AB79")]
        case .purpleGoldRadial:
            return [Color(hex: "EF7D2B"), Color(hex: "C6696F"), Color(hex: "6A46CE")]
        case .greenOrangeLinear:
            return [Color(hex: "008000", opacity: 0.45), Color(hex: "FFA500", opacity: 0.45)]
        case .purpleBlueLinear:
            return [Color(hex: "5757FB", opacity: 0.45), Color(hex: "2A7FCF", opacity: 0.70)]
        case .blueBlackLinear:
            return [Color(hex: "0D0D0D", opacity: 1.0), Color(hex: "2A7FCF", opacity: 0.70)]
        case .creamLinear:
            return [SpaceColors.cream, SpaceColors.cream]
        }
    }
    
    var locationMix: [CGFloat] {
        switch self {
        case .blueLightRadial:
            return [0, 0.94]
        case .goldLightRadial:
            return [0, 0.43, 1]
        case .purpleGoldRadial:
            return [0, 0.31, 1.00]
        default:
            return [0, 1.00]
        }
    }
    
    public func rStyle() -> RadialGradient {
        let startRadius: CGFloat = 0
        let endRadius: CGFloat = 360
        
        let stops: [Gradient.Stop] = zip(colorMix, locationMix).map({ Gradient.Stop(color: $0.0, location: $0.1)})
        
        return RadialGradient(gradient: Gradient(stops: stops), center: .topLeading, startRadius: startRadius, endRadius: endRadius)
    }
    
    public func build() -> some View {
        rStyle()
    }
    
    public func lStyle(start: UnitPoint = .topLeading,
                       end: UnitPoint = .bottomTrailing) -> LinearGradient {
        LinearGradient(colors: colorMix, startPoint: start, endPoint: end)
    }
}


#Preview {
    ScrollView {
        HStack {
            Circle()
                .fill(SpaceGradient.blueLightRadial.rStyle())
                .frame(width: 200, height: 200)
                .shadow(color: .black.opacity(0.25) ,radius: 4)
                
            Circle()
                .fill(SpaceGradient.greenOrangeLinear.lStyle())
                .frame(width: 150, height: 150)
                .shadow(color: .black.opacity(0.25) ,radius: 4)
        }
        .padding(.horizontal, 16)
      
        HStack {
            Circle()
                .fill(SpaceGradient.goldLightRadial.rStyle())
                .frame(width: 200, height: 200)
                .shadow(color: .black.opacity(0.25) ,radius: 4)
            
            
            Circle()
                .fill(SpaceGradient.greenOrangeLinear.rStyle())
                .frame(width: 150, height: 150)
                .shadow(color: .black.opacity(0.25) ,radius: 4)
        }
        .padding(.horizontal, 16)
        
        HStack {
            Circle()
                .fill(SpaceGradient.greenOrangeLinear.rStyle())
                .frame(width: 200, height: 200)
                .shadow(color: .black.opacity(0.25) ,radius: 4)
            
            Circle()
                .fill(SpaceGradient.purpleBlueLinear.rStyle())
                .frame(width: 150, height: 150)
                .shadow(color: .black.opacity(0.25) ,radius: 4)
        }
        .padding(.horizontal, 16)
    }
    .frame(height: 800, alignment: .center)
}
