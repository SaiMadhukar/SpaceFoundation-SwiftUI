//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/15/25.
//

import SwiftUI


public struct NavigationBackButtonModifier: ViewModifier {
    
    private var action: (() -> Void)
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                       action()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(SpaceColors.blue100)
                    }
                }
            }
    }
}
