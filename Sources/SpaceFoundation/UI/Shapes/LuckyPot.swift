//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/14/24.
//

import SwiftUI

public struct BubblePoint: Hashable, Sendable {
    
    var id: Int
    var point: CGPoint
    var offset: CGPoint
}


public class BubbleModel: ObservableObject {
    
    @Published var data: [BubblePoint] = []
    
    init() {
        for i in Range(0...200) {
            
            let randomX: Double = Double.random(in: -400...400)
            let randomY: Double = Double.random(in: 100...300)
            
            let offsetX: Double = Double.random(in: -300...300)
            let offsetY: Double = -300
            let point = BubblePoint(id: i, point: CGPoint(x: randomX, y: randomY),
                                    offset: CGPoint(x: offsetX, y: offsetY))
            
            print(point)
            self.data.append(point)
        }
    }
    
    func reset() {
        
    }
    
    func addMore() {
        for i in Range(0...50) {
            
            let randomX: Double = Double.random(in: -400...400)
            let randomY: Double = Double.random(in: 100...300)
            
            let offsetX: Double = Double.random(in: -300...300)
            let offsetY: Double = -300
            let point = BubblePoint(id: i, point: CGPoint(x: randomX, y: randomY),
                                    offset: CGPoint(x: offsetX, y: offsetY))
            
            self.data.append(point)
        }
        print("Added More")
    }
}


public struct LuckyPot: View {
    
    @StateObject var bubbleModel = BubbleModel()
    @State var moveToOffSet: Bool = false
    @State var isPopped: Bool = false
    
    @State var viewId: Int = 1
    
    public init() {
    }
    
    public var body: some View {
        VStack {
            TimelineView(.animation(minimumInterval: 200, paused: false)) { context in
                
                ForEach(bubbleModel.data, id: \.id) { model in
                    Bubble(model: model,
                               moveToOffSet: $moveToOffSet,
                               isPopped: $isPopped
                    )
                        .onAppear {
                            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                                print(bubbleModel.data.count)
                                moveToOffSet = true
                            }
                        }
                }
            }
        }
    }
}

public struct Bubble: View {
    
    private let size: CGFloat = 5
    var model: BubblePoint
    
    @Binding var moveToOffSet: Bool
    @Binding var isPopped: Bool
    
    public var body: some View {
        VStack {
            Circle()
                .foregroundColor(.cyan.opacity(0.5))
                .offset(x: model.point.x, y: model.point.y)
                .offset(
                    x: (moveToOffSet ? model.offset.x : 0),
                    y: (moveToOffSet ? model.offset.y : 0)
                )
        }
        .frame(width: size * 3, height: size * 3)
        .opacity(isPopped ? 0 : 1)
    }
}


#Preview {
    LuckyPot()
}
