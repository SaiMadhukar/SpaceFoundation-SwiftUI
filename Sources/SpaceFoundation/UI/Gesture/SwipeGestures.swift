//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/3/25.
//

import SwiftUI

public enum HorizontalSwipeDirection: String {
    case left, right
}

extension View {
    public func addHorizontalGesture(direction: HorizontalSwipeDirection, action: @escaping () -> Void) -> some View {
        self.modifier(HorizontalGestureRecognizer(reqDirection: direction, action: action))
    }
}

public struct HorizontalGestureRecognizer: ViewModifier {
    
    init(reqDirection: HorizontalSwipeDirection, action: (@escaping () -> Void)) {
        self.reqDirection = reqDirection
        self.action = action
    }
    
    var reqDirection: HorizontalSwipeDirection
    var action: (() -> Void)?
    
    public func body(content: Content) -> some View {
        var direction: HorizontalSwipeDirection?
        content
            .gesture(DragGesture(minimumDistance: 50, coordinateSpace: .local)
                .onChanged({ value in
                    direction = detect(startLocation: value.startLocation, current: value.location)
                })
                    .onEnded({ _ in
                        if direction == .some(reqDirection) {
                            action?()
                        }
                    })
            )
    }
    
    public func detect(startLocation: CGPoint, current: CGPoint) -> HorizontalSwipeDirection? {
        if startLocation.x < current.x {
            return .left
        } else if startLocation.x > current.x {
            return .right
        } else { return nil }
    }
}
