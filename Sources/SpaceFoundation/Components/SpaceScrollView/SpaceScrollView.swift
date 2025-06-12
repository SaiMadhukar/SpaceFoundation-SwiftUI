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
    private var showScrollIndicators: Bool
    
    public init(offset: Binding<CGFloat>, showScrollIndicators: Bool = true, @ViewBuilder content: () -> Content) {
        self.content = content()
        _offset = offset
        self.showScrollIndicators = showScrollIndicators
    }
    
    
    public var body: some View {
        ScrollView(showsIndicators: showScrollIndicators) {
            content
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: ScrollOffsetPreferenceKey.self, value: proxy.frame(in: .named(outerScrollView)).minY)
                    }
                )
        }
        .padding(.zero)
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
