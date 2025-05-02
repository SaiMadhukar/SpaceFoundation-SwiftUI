//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 5/2/25.
//

import Foundation
import SwiftUI

public struct LinearProgressBar: View {
    let progress: CGFloat // Value between 0 and 1
    let height: CGFloat
    let backgroundColor: Color
    let foregroundColor: LinearGradient
    let progressText: String
    
    public init(
        progress: CGFloat,
        progressText: String,
        height: CGFloat = 12,
        backgroundColor: Color = SpaceColors.gray10,
        foregroundColor: LinearGradient = SpaceGradient.purpleBlueLinear.lStyle()
    ) {
        self.progress = min(max(progress, 0), 1) // Clamp between 0 and 1
        self.height = height
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.progressText = progressText
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background
                RoundedRectangle(cornerRadius: height/2)
                    .fill(backgroundColor)
                
                // Progress
                RoundedRectangle(cornerRadius: height/2)
                    .fill(foregroundColor)
                    .frame(width: geometry.size.width * progress)
                
                // Progress Text
                Text(progressText)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(progress > 0.5 ? .white : .primary)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 4)
            }
        }
        .frame(height: height)
    }
}

#Preview {
    VStack(spacing: 20) {
        LinearProgressBar(
            progress: 0.0,
            progressText: "0/10"
        )
        .frame(width: 200)
        
        LinearProgressBar(
            progress: 0.7,
            progressText: "7/10"
        )
        .frame(width: 200)
        
        LinearProgressBar(
            progress: 1.0,
            progressText: "2/10"
        )
        .frame(width: 200)
    }
    .padding()
    
}
