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
    
    @ViewBuilder public func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if (condition) {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder public func `ifInline`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder public func myPresentation(device: DeviceType, detents: Set<PresentationDetent>) -> some View {
        if device == .iPhone {
            self
                .presentationDetents(detents)
                .presentationDragIndicator(.visible)
        } else {
            self
                .presentationDragIndicator(.visible)
        }
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
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

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner

    init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
