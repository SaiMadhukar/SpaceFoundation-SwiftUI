//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/14/24.
//

import SwiftUI

public struct CircleControl: Hashable {
    var rotationDegress: CGFloat = 0
}

public struct CircleView: View {
    
    @State var width: CGFloat = 200
    @State var height: CGFloat = 200
    
    private var rotationGesture: RotationGesture = .init(minimumAngleDelta: .degrees(5))
    
    @State private var circleControl = CircleControl()
    private var gradient: AngularGradient = AngularGradient(
        gradient: Gradient(colors: [Color.blue.opacity(0.70), .clear]),
        center: .center,
        startAngle: .degrees(0),
        endAngle: .degrees(400)
    )
    
    public init() {}
    
    public var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(gradient)
                    .rotationEffect(.degrees(Double(circleControl.rotationDegress)))
                    .frame(width: width, height: height)
                    .mask {
                        strokePath
                            .frame(width: width, height: height)
                    }
            }
            knobView
        }
        .onAppear(perform: {
            withAnimation(.linear(duration: 4.0).repeatForever(autoreverses: false)) {
                circleControl.rotationDegress = 360
            }
        })
    }
    
    @ViewBuilder
    private var strokePath: some View {
        Circle()
            .stroke(.white, lineWidth: 32)
            .shadow(color: SpaceColors.primary.opacity(0.20), radius: 10, x: 0, y: 0)
            .frame(width: width, height: height)
    }
    
    private var knobView: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            
            path.addLine(to: CGPoint(x: 0, y: 300))
        }
        .fill(Color.orange.opacity(0.75))
        .frame(width: 200, height: 400)
    }
    
    private var strokeView: some View {
        
        Circle()
            .stroke(.orange.opacity(0.5), lineWidth: 32)
            .shadow(color: SpaceColors.primary.opacity(0.20), radius: 10, x: 0, y: 0)
            .frame(width: width, height: height)
    }
}


#Preview {
    CircleView()
        .background(.white)
}
