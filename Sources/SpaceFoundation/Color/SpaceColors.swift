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

public enum SpaceColors: String {
    case blue00
    case blue10
    case blue90
    case background
    
    private var loadColor: UIColor? {
        UIColor(named: self.rawValue)
    }
    
    public var color: Color {
        Color(uiColor: loadColor ?? .clear)
    }
}


#Preview {
    VStack {
        Text("Login")
    }
    .frame(width: 400, height: 400)
    .background(SpaceColors.blue00.color)
}
