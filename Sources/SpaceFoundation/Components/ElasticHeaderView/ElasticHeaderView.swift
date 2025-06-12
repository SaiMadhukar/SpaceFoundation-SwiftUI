//
//  StretchableHeaderView.swift
//  CarSpace
//
//  Created by Sai Madhukar Somu on 5/5/25.
//

import Foundation
import SwiftUI

public struct ElasticHeaderView<HeaderContent: View, BodyContent: View>: View {
    
    private let headerFixedHeight: CGFloat
    private let bottomFixedSpace: CGFloat
    private let headerColor: Color
    private let contentColor: Color
    private let header: HeaderContent
    private let contentView: BodyContent
    
    @State var offsetY: CGFloat = 0.0
    
    public init(headerFixedHeight: CGFloat = 100,
         bottomFixedSpace: CGFloat = 50,
         headerColor: Color = SpaceColors.orange75,
         contentColor: Color = SpaceColors.white,
         @ViewBuilder header: () -> HeaderContent,
         @ViewBuilder contentView: () -> BodyContent) {
        
        self.headerFixedHeight = headerFixedHeight
        self.bottomFixedSpace = bottomFixedSpace
        self.headerColor = headerColor
        self.contentColor = contentColor
        self.header = header()
        self.contentView = contentView()
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            header
                .frame(height: headerFixedHeight + max(0, -offsetY), alignment: .topLeading)
                .transformEffect(.init(translationX: 0, y: -min(0, max(0, offsetY))))
                .padding(16)
            
            
            VStack(spacing: .zero) {
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: headerFixedHeight - CGFloat(min(headerFixedHeight, -offsetY)))
                
                SpaceScrollView(offset: $offsetY) {
                    LazyVStack(alignment: .leading, spacing: .zero, pinnedViews: .sectionHeaders) {
                        Section {
                            contentView
                        } header: {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [
                                        contentColor, contentColor.opacity(0.10),
                                                                .clear, .clear]),
                                                   startPoint: .top,
                                                   endPoint: .bottom)
                                )
                                .frame(height: 16)
                        }
                    }
                }
                .background(contentColor)
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .shadow(radius: 4, x: 0, y: -4)
                
                Rectangle()
                    .fill(SpaceColors.primary)
                    .frame(height: bottomFixedSpace)
            }
        }
        .background(headerColor.ignoresSafeArea(.all, edges: .top))
    }
}
