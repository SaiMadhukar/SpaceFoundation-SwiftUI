//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/15/25.
//

import Foundation
import SwiftUI

public struct GoalSlider: View {
    
    private var sliderWidth: Double = 0.0
    private var foreground: SpaceGradient
    private var background: Color
    
    var amount: Double
    var target: Double
    
    public init(amount: Double,
                target: Double,
                foreground: SpaceGradient,
                background: Color = SpaceColors.black25
    ) {
        self.sliderWidth = UIScreen.main.bounds.width - 32 * 2
        self.foreground = foreground
        self.background = background
        self.amount = amount
        self.target = target
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(background)
                .frame(height: 20)
            
            Rectangle()
                .frame(width: min(CGFloat(amount / target) * sliderWidth, sliderWidth), height: 20)
                .foreground(foreground.lStyle())
        }
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
}

public struct SpaceSlider: View {
    
    @Environment(\.windowSize) var screenSize: CGSize
    @Binding var amount: Double
    
    private var maxAmount: Double = 0.0
    private var sliderWidth: Double = 0.0
    private var height: CGFloat = 30
    
    public init(amount: Binding<Double>, maxAmount: Double = 0.0, height: CGFloat = 30) {
        _amount = amount
        self.maxAmount = maxAmount
        self.sliderWidth = UIScreen.main.bounds.width - 16 * 2
        self.height = height
    }
    
    
    public var body: some View {
        sliderView
    }
    
    
    var sliderView: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(SpaceColors.black10)
                    .frame(height: 30)
                
                Rectangle()
                    .fill(SpaceGradient.purpleBlueLinear.lStyle())
                    .frame(width: min(CGFloat(amount / maxAmount) * sliderWidth, sliderWidth), height: height)
            }
            .cornerRadius(10)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let newAmount = (value.location.x / sliderWidth) * maxAmount
                        amount = min(max(newAmount, 1), maxAmount)
                    }
            )
            .drawingGroup()
            
            Text("$\(Int(amount))")
                .font(.largeTitle)
                .padding()
                .frame(alignment: .center)
        }
        .padding(.horizontal, 16)
    }
}


#Preview {
    @State var amount: Double = 40.0
    VStack {
        
        GoalSlider(amount: 80, target: 100, foreground: .purpleGoldRadial, background: SpaceColors.black10)
            
        
        SpaceSlider(amount: $amount, maxAmount: 500)
    }
}
