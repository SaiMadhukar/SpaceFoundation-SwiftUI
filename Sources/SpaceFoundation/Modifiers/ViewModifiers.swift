//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/8/24.
//

import Foundation
import SwiftUI


extension View {
    
    @ViewBuilder
    public func centerHorizontally() -> some View {
        HStack {
            Spacer()
            
            self
            
            Spacer()
        }
    }
}
