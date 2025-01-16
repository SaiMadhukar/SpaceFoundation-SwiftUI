import SwiftUI
import UIKit

public struct Compass: View {
    
    @Environment(\.windowSize) var screenSize: CGSize
    
    @Binding private var amount: Double
    @State var sliderX: Double = 0
    
    private let maxAmount: Double = 500
    private let step: Double = 5
    private var edgePadding: Double = 0
    
    var dragGesture: some Gesture {
        return DragGesture()
                .onChanged { value in
                    let newLoc = sliderX + (value.translation.width * 0.16)
                    print("NewLoc:", newLoc)
                    if newLoc > 0.0 {
                        sliderX = min(edgePadding, newLoc)
                        amount = maxAmount * Double(min(0, Double(abs(newLoc) + edgePadding) / 10) / 100)
                    } else {
                        sliderX = max((edgePadding / 2) - 1000, newLoc)
                        amount = maxAmount * Double(min(100, Double(abs(newLoc) + edgePadding) / 10) / 100)
                    }
                    
                    print("SliderX ", sliderX)
                }
    }
    
    init(value: Binding<Double>) {
        _amount = value
        self.edgePadding = (UIScreen.main.bounds.width) / 3
    }
    
    public var body: some View {
        VStack {
            spokesView
            
            Spacer()
            
            sliderView
        }
    }
    
    public var spokesView: some View {
        VStack {
            Text("Choose an amount")
                .font(.headline)
            
            VStack(spacing: 0) {
                HStack(alignment: .bottom) {
                    Spacer()
                        Image(systemName: "arrow.trianglehead.merge")
                            .foreground(Color.black)
                            .rotationEffect(.degrees(-180))
                            .frame(width: 48, height: 48)
                    Spacer()
                }
                
                HStack(alignment: .top) {
                   ForEach( 0..<Int(Int(maxAmount / step) + 1)) { index in
                       Rectangle()
                           .fill(index % 10 == 0 ? Color.black : Color.gray)
                           .frame(width: 2, height: index % 5 == 0 ? 30 : 15)
                    }
                }
                .frame(width: screenSize.width - edgePadding, alignment: .leading)
                .padding(.horizontal, 16)
                .offset(x: sliderX)
                .clipped()
                .gesture(dragGesture)
            }
            
       
           
           Text("$\(Int(amount))")
               .font(.largeTitle)
               .padding()
       }
        
    }

    public var sliderView: some View {
        VStack {
            Text("Choose an amount")
                .font(.headline)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 20)
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: CGFloat(amount / maxAmount) * UIScreen.main.bounds.width, height: 20)
            }
            .cornerRadius(10)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let newAmount = (value.location.x / UIScreen.main.bounds.width) * maxAmount
                        print("new Amount: ", newAmount, "Screen width: ", screenSize.width)
                        self.amount = min(max(newAmount, 1), maxAmount)
                    }
            )
            .padding()
            
            Text("$\(Int(amount))")
                .font(.largeTitle)
                .padding()
        }
        .padding()
    }
}

#Preview {
    Compass(value: .constant(30))
}
