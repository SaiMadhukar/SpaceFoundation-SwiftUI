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
    public func addHorizontalGesture(action: @escaping (_ direction: HorizontalSwipeDirection) -> Void) -> some View {
        self.modifier(HorizontalGestureRecognizer(action: action))
    }
}

public struct HorizontalGestureRecognizer: ViewModifier {
    
    init(action: (@escaping (_ direction: HorizontalSwipeDirection) -> Void)) {
        self.action = action
    }
    
    var action: ((_ direction: HorizontalSwipeDirection) -> Void)?
    
    public func body(content: Content) -> some View {
        var direction: HorizontalSwipeDirection?
        content
            .gesture(DragGesture(minimumDistance: 50, coordinateSpace: .local)
                .onChanged({ value in
                    direction = detect(startLocation: value.startLocation, current: value.location)
                })
                    .onEnded({ _ in
                        if let direction = direction {
                            action?(direction)
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
