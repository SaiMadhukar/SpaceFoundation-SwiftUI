//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 12/18/24.
//

import SwiftUI

extension View {
    public func foreground<Overlay: View>(_ overlay: Overlay) -> some View {
        _CustomForeground(overlay: overlay, for: self)
    }
    
    public func setNavigationBackButton(action: @escaping () -> Void) -> some View {
        self.modifier(NavigationBackButtonModifier(action: action))
    }
    
    public func showExpandButton(isExpanded: Binding<Bool>, action: (() -> Void)? = nil) -> some View {
        Button {
            withAnimation(.snappy(duration: 0.2)) {
                isExpanded.wrappedValue.toggle()
            }
        } label: {
            Image(systemName: isExpanded.wrappedValue ? "chevron.up" : "chevron.down")
                .foreground(SpaceColors.white)
        }
        .frame(width: 32, height: 32, alignment: .bottom)
    }
}

private struct _CustomForeground<Content: View, Overlay: View>: View {
    let content: Content
    let overlay: Overlay
    
    internal init(overlay: Overlay, for content: Content) {
        self.content = content
        self.overlay = overlay
    }
    
    var body: some View {
        content.overlay(overlay).mask(content)
    }
}
