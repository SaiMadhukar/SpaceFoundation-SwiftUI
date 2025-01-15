//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/6/25.
//

import Foundation
import SwiftUI

public struct SpaceRowToggle: View {
    
    @Binding var toggle: Bool
    private var image: Image
    private var title: String
    private var reqToggle: Bool
    private var backgroundColor: Color
    
    public init(
        image: Image,
        title: String,
        reqToggle: Bool = true,
        toggle: Binding<Bool>,
        backgroundColor: Color = SpaceColors.white
    ) {
        _toggle = toggle
        self.image = image
        self.title = title
        self.reqToggle = reqToggle
        self.backgroundColor = backgroundColor
    }
        
        
    public var body: some View {
        VStack(spacing: 0) {
            contentView
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
            
            if reqToggle {
                Toggle("", isOn: $toggle)
                    .frame(width: 24, height: 24)
                    .scaleEffect(0.8)
                    .padding(.trailing, 8)
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
        @State var toggle: Bool = true
        SpaceRowToggle(image: FoundationImage.darkMode.load, title: "Profile", reqToggle: true, toggle: $toggle)
    }
    .frame(width: 400, height: 300)
    .background(.blue.opacity(0.45))
}

