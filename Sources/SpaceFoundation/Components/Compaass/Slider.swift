//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/15/25.
//

import Foundation
import SwiftUI

public struct SpaceSlider: View {
    
    @Environment(\.windowSize) var screenSize: CGSize
    @Binding var amount: Double
    
    private var maxAmount: Double = 0.0
    private var sliderWidth: Double = 0.0
    
    public init(amount: Binding<Double>, maxAmount: Double = 0.0) {
        _amount = amount
        self.maxAmount = maxAmount
        self.sliderWidth = UIScreen.main.bounds.width - 16 * 2
    }
    
    
    public var body: some View {
        sliderView
    }
    
    
    var sliderView: some View {
        VStack {
            Text("Choose an amount")
                .font(.headline)
            
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(SpaceColors.black25)
                    .frame(height: 20)
                
                Rectangle()
                    .fill(SpaceGradient.purpleBlueLinear.lStyle())
                    .frame(width: CGFloat(amount / maxAmount) * sliderWidth, height: 20)
            }
            .cornerRadius(10)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let newAmount = (value.location.x / sliderWidth) * maxAmount
                        amount = min(max(newAmount, 1), maxAmount)
                    }
            )
            .padding(.horizontal, 16)
            .drawingGroup()
            
            Text("$\(Int(amount))")
                .font(.largeTitle)
                .padding()
        }
    }
}


#Preview {
    @State var amount: Double = 0.0
    VStack {
        SpaceSlider(amount: $amount, maxAmount: 500)
    }
}
