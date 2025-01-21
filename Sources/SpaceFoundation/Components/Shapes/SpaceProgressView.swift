//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/20/25.
//

import Foundation
import SwiftUI

public struct SLine : Sendable {
    var start: CGPoint
    var end: CGPoint
}

public struct SpaceProgressView: View {
    
    var locations: [SLine] = [
        SLine(start: CGPoint(x: 0, y: 0), end: CGPoint(x: 100, y: 0)),
        SLine(start: CGPoint(x: 100, y: 0), end: CGPoint(x: 100, y: 100)),
        SLine(start: CGPoint(x: 100, y: 100), end: CGPoint(x: 0, y: 100)),
        SLine(start: CGPoint(x: 0, y: 100), end: CGPoint(x: 0, y: 0))
    ]
    
    @State var currLine: SLine = SLine(start: CGPoint(x: 0, y: 0), end: CGPoint(x: 100, y: 0))
    @State private var currIndex: Int = 0
        
    public var body: some View {
        ProgressViewPath(start: $currLine.start, end: $currLine.end)
            .stroke(Color.red, lineWidth: 2)
            .frame(width: 100, height: 100)
            .background(Color.blue.opacity(0.45))
            .onAppear(perform: {
                withAnimation(.easeInOut(duration: 2.0).repeatForever()) {
                    self.currIndex += 1
                    self.currLine = self.locations[ currIndex % locations.count]
                    print(self.currLine)
                }
            })
    }
}


struct ProgressViewPath: Shape {
    
    var animatableData: CGPoint {
        get {
            return end
        } set {
            start = end
            end = newValue
        }
    }
    
    @Binding var start: CGPoint
    @Binding var end: CGPoint
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: start)
            path.addLine(to: end)
        }
    }
}


#Preview {
    VStack {
        SpaceProgressView()
    }
}
