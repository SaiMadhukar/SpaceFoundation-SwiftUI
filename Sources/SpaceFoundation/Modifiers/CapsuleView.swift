//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/8/24.
//

import Foundation
import SwiftUI

public struct Capsule: Shape {
    
    public func path(in rect: CGRect) -> Path {
        return Path(roundedRect: rect, cornerRadius: rect.height / 2)
    }
}

public struct Circle: Shape {
    public func path(in rect: CGRect) -> Path {
        return Path(roundedRect: rect, cornerRadius: rect.width + rect.height / 2)
    }
}

public struct CircleStyle: ShapeStyle {
    public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        if environment.colorScheme == .light {
            return Color.blue
        } else {
            return Color.red
        }
    }
}


public struct CapsuleButton: View {
    
    private var title: String
    private var action: (() -> Void)?
    @State var clickedState: Bool = true
    
    public init(title: String, action: (() -> Void)? = nil) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        
        
        SpaceButton(title: title,
                    configuration: SpaceButtonDefaults.primary, action: {
            action?()
        })
        .frame(width: 200, height: 200)
            .background(
                Circle()
                   .fill(LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .top, endPoint: .bottom))
            )
            
    }
    
    public var buttonView: some View {
        SpaceButton(title: title,
                    configuration: SpaceButtonDefaults.primary, action: {
            action?()
        })
    }
}


#Preview {
    CapsuleButton(title: "Good") {
        print("Good")
    }
}
