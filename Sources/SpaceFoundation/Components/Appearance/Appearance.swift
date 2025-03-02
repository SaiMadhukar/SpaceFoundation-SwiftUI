//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 3/2/25.
//

import Foundation
import SwiftUI

public protocol SpaceAppearance: Identifiable, CaseIterable, Equatable {
    var gradient: SpaceGradient { get }
    var id: Int { get }
}

public struct SpaceAppearanceBar<I: SpaceAppearance>: View {
    
    private var appearance: [I]
    @Binding var selection: I
    
    public init(selection: Binding<I>, appearance: [I]) {
        self.appearance = appearance
        _selection = selection
    }
    
    public var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 8) {
                ForEach(appearance) { item in
                    Button(action: {
                        selection = item
                    }, label: {
                        ZStack {
                            Circle()
                                .fill(item.gradient.lStyle())
                                .frame(width: 40, height: 40)
                                .overlay {
                                    if selection == item {
                                        Circle()
                                            .fill(.clear, strokeColor: .black, stroke: .init(lineWidth: 2))
                                            .frame(width: 45, height: 45)
                                    }
                                }
                        }
                    })
                    .frame(width: 50, height: 50)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}


enum mockApp: SpaceAppearance {
    
    case lift, food, one, two, three, four
    
    public var id: Int {
        switch self {
        case .lift:
            return 1
        case .food:
            return 2
        case .one:
            return 3
        case .two:
            return 4
        case .three:
            return 5
        case .four:
            return 6
        }
    }
    
    var gradient: SpaceGradient {
        switch self {
        case .lift:
            return SpaceGradient.redPinkRadial
        case .food:
            return SpaceGradient.blueLightRadial
        case .one:
            return SpaceGradient.redYellowRadial
        case .two:
            return SpaceGradient.greenlightRadial
        case .three:
            return SpaceGradient.goldLightRadial
        case .four:
            return SpaceGradient.purpleBlueLinear
        default:
            return SpaceGradient.blueLightRadial
        }
    }
}

#Preview {
    VStack {
        SpaceAppearanceBar<mockApp>(
            selection: .constant(mockApp.lift),
            appearance: mockApp.allCases
        )
    }
}
