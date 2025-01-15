//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 12/10/24.
//

import SwiftUI

public struct SpaceLabel: View {
    
    @State private var title: String
    @State private var cornerRadius: CGFloat = 10
    @State private var configuration: SpaceLabelConfiguration
    
    public init(title: String,
                configuration: SpaceLabelConfiguration = .primary) {
        _title = State(initialValue: title)
        
        self.configuration = configuration
    }
    
    public var body: some View {
        VStack {
            Label(title, systemImage: configuration.icon ?? "")
                .labelStyle(SpaceLabelStyle(userConfig: configuration))
                .frame(height: configuration.height)
        }
    }
}

#Preview {
    
    VStack {
        SpaceLabel(title: "Good Morning - Primary", configuration: .primary)
        
        SpaceLabel(title: "Good Morning - Secondary", configuration: .secondary)
        
        SpaceLabel(title: "Good Morning - Tertiary", configuration: .secondary)
        
        SpaceLabel(title: "Good Morning - Plain", configuration: .plain)
    }
}
