//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/2/25.
//

import SwiftUI
import SwiftUICore

public struct BottomSheet<Content: View>: View {
    
    @Environment(\.dismiss) var dismiss: DismissAction
    @State private var title: String = ""
    @State private var fontCategory: FontCategory = .heading
    @State private var weight: Font.Weight = .bold
    @State private var color: Color = .black
    
    private var contentView: Content
        
    public init(title: String, content: Content, fontStyle: FontCategory = .heading, weight: Font.Weight = .bold, color: Color = .black) {
        self.title = title
        self.contentView = content
        self.fontCategory = fontStyle
        self.weight = weight
        self.color = color
    }
    
    public var body: some View {
        VStack {
            titleView
            
            Spacer()
            
            ScrollView {
                VStack {
                    contentView
                }
            }
        }
    }
    
    var titleView: some View {
        HStack {
            Text(title)
                .spaceFontStyle(category: fontCategory, weight: weight, color: color)
                .padding()
        }
    }
}
