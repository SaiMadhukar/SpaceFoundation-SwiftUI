//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/6/25.
//

import Foundation
import SwiftUI

public struct SpaceRow: View {
    
    private var image: Image
    private var title: String
    private var rightArrowReq: Bool
    private var action: () -> Void
    private var backgroundColor: Color
    
    public init(
        image: Image,
        title: String,
        rightArrowReq: Bool = true,
        action: @escaping () -> Void,
        backgroundColor: Color = SpaceColors.white
    ) {
        self.image = image
        self.title = title
        self.rightArrowReq = rightArrowReq
        self.action = action
        self.backgroundColor = backgroundColor
    }
        
        
    public var body: some View {
        VStack(spacing: 0) {
            Button {
                action()
            } label: {
                contentView
            }
        }
        .background(.clear)
        .padding(.horizontal, 16)
    }
        
    var contentView: some View {
        HStack(spacing: 16) {
            image
                .resizable()
                .frame(width: 24, height: 24)
            
            Text(title)
                .spaceFontStyle(category: .bodyMedium, weight: .regular, color: SpaceColors.blue100)
            
            Spacer(minLength: 8)
            
            if rightArrowReq {
                FoundationImage.rightArrow.load
                    .foregroundColor(SpaceColors.blue100)
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 48)
        .background(SpaceColors.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}


#Preview {
    VStack {
        SpaceRow(image: FoundationImage.darkMode.load, title: "Profile", rightArrowReq: true, action: {
            print("Profile")
        })
    }
    .frame(width: 400, height: 300)
    .background(.blue.opacity(0.45))
}
