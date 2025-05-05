//
//  SpaceScrollView.swift
//  CarSpace
//
//  Created by Sai Madhukar Somu on 5/5/25.
//

import Foundation
import SwiftUI

public struct SpaceScrollView<Content: View>: View {
    
    @Binding var offset: CGFloat
    private let content: Content
    private let outerScrollView: String = "OuterScrollView"
    
    public init(offset: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
        self.content = content()
        _offset = offset
    }
    
    
    public var body: some View {
        ScrollView() {
            content
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: ScrollOffsetPreferenceKey.self, value: proxy.frame(in: .named(outerScrollView)).minY)
                    }
                )
        }
        .coordinateSpace(name: outerScrollView)
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { newOffset in
            self.offset = newOffset
        }
    }
}

public struct ScrollOffsetPreferenceKey: PreferenceKey {
    
    public static let defaultValue: CGFloat = .zero
        
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
