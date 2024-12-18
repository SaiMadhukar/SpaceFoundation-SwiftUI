//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/10/24.
//

import SwiftUI

public struct SpaceButton: View {
    
    private var title: String
    private var configuration: SpaceButtonConfiguration
    private var action: (() -> Void)?
    
    public init(title: String,
                configuration: SpaceButtonConfiguration = .primary,
                action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.configuration = configuration
    }
    
    public var body: some View {
        Button(title, action: {
           action?()
        })
        .buttonStyle(SpaceButtonStyle(userConfig: configuration))
    }
}

#Preview {
    ZStack {
        VStack(spacing: 32) {
            SpaceButton(title: "Submit", configuration: .primary) {
                print("Submit")
            }
            .padding(.bottom, 16)
            
            SpaceButton(title: "Submit", configuration: .secondary) {
                print("Submit")
            }
            .padding(.bottom, 16)
            
            SpaceButton(title: "Submit", configuration: .tertiary) {
                print("Submit")
            }
            .padding(.bottom, 16)
            
            SpaceButton(title: "Submit", configuration: .plain) {
                print("Submit")
            }
            .padding(.bottom, 16)
        }
    }
    .frame(width: 400, height: 900)
    .background(Color.linearGradient)
}
