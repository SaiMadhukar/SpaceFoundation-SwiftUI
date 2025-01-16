//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/15/25.
//

import Foundation
import UIKit
import SwiftUICore


public struct MainWindowSizeKey: @preconcurrency EnvironmentKey {
     @MainActor public static let defaultValue: CGSize = UIScreen.main.bounds.size
}

extension EnvironmentValues {
    
    var windowSize: CGSize {
        get { self[MainWindowSizeKey.self] }
        set { self[MainWindowSizeKey.self] = newValue }
    }
}
