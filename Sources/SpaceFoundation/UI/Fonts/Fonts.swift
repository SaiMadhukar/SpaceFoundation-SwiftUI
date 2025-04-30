//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/28/24.
//

import Foundation
import SwiftUI

public enum FontCategory {
    
    private struct Constants {
        static let notoSans = "App-Regular"
        static let notoSansMedium = "App-Medium"
        static let notoSansSemiBold = "App-SemiBold"
        static let notoSansBold = "App-Bold"
        static let pacifico = "Pacifico-Regular"
        static let notoSherif = "NotoSerif-Bold"
    }
    
    case pageTitle
    case heading, headingSmall, headingLarge, headingXLarge, headingXXLarge
    case subheading, subHeadingMedium, subheadingLarge, subHeadingXLarge
    case body, caption, bodyMedium, bodyLarge, bodyXLarge
    case button, primaryButton, secondaryButton, tertiaryButton
    case link
    case spaceFont
    case spaceFontSmall
    case amountField
    
    public var size: CGFloat {
        switch self {
        case .pageTitle:
            return 32
        case .headingSmall:
            return 18
        case .heading:
            return 20
        case .headingLarge:
            return 22
        case .headingXLarge:
            return 24
        case .headingXXLarge:
            return 28
        case .subheading, .subHeadingXLarge:
            return 14
        case .subheadingLarge:
            return 18
        case .subHeadingMedium:
            return 16
        case .caption:
            return 12
        case .body:
            return 14
        case .bodyMedium, .bodyLarge, .bodyXLarge:
            return 16
        case .button, .primaryButton, .secondaryButton, .tertiaryButton:
            return 16
        case .link:
            return 14
        case .spaceFont:
            return 26
        case .spaceFontSmall:
            return 22
        case .amountField:
            return 96
        }
    }
    
    public var fontColor: Color {
        switch self {
        case .heading, .headingLarge, .headingXLarge, .headingXXLarge, .pageTitle, .headingSmall, .amountField:
            return SpaceColors.primary
        case .subheading, .subHeadingMedium, .subheadingLarge, .subHeadingXLarge:
            return SpaceColors.secondary
        case .caption:
            return SpaceColors.secondary
        case .body, .bodyMedium, .bodyLarge, .bodyXLarge:
            return SpaceColors.primary
        case .button, .primaryButton, .secondaryButton, .tertiaryButton:
            return SpaceColors.primary
        case .spaceFont, .spaceFontSmall:
            return SpaceColors.primary
        case .link:
            return .green.opacity(0.75)
        }
    }
    
    public var font: Font {
        switch self {
        case .headingSmall, .heading, .headingLarge, .headingXLarge, .headingXXLarge, .pageTitle:
            return Font.custom(Constants.notoSansBold, size: size)
        case .subheading, .subHeadingMedium, .subheadingLarge, .subHeadingXLarge:
            return Font.custom(Constants.notoSansSemiBold, size: size)
        case .body, .bodyMedium, .bodyLarge, .bodyXLarge:
            return Font.custom(Constants.notoSans, size: size)
        case .spaceFont, .spaceFontSmall:
            return Font.custom(Constants.pacifico, size: size)
        case .amountField:
            return Font.custom(Constants.notoSherif, size: size)
        default:
            return Font.custom(Constants.notoSans, size: size)
        }
    }
}

#Preview {
    VStack {
        SpaceLabel(title: "Space Foundation", configuration: .primary)
        SpaceLabel(title: "Space Foundation", configuration: .secondary)
        
        SpaceLabel(title: "Space Foundation", configuration: .space)
    }
}
