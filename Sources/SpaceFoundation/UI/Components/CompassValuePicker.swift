import SwiftUI

public struct CompassValuePicker: View {
    
    @Binding private var amount: Double
    private let maxAmount: Double = 500
    private let step: Double = 5
    
    
    init(value: Binding<Double>) {
        _amount = value
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
                   
                   GeometryReader { geometry in
                       HStack {
                           ForEach(0..<Int(maxAmount / step) + 1) { index in
                               let angle = Angle(degrees: Double(index) * (360 / (maxAmount / step)))
                               VStack {
                                   Rectangle()
                                       .fill(index % 10 == 0 ? Color.black : Color.gray)
                                       .frame(width: 2, height: index % 10 == 0 ? 30 : 15)
                                   Spacer()
                               }
                               .rotation3DEffect(angle, axis: (x: 0, y: 0, z: 1))
                           }
                       }
                       .frame(width: geometry.size.width, height: geometry.size.width)
                       .rotation3DEffect(
                           .degrees(amount / maxAmount * 360),
                           axis: (x: 0, y: 1, z: 0)
                       )
                       .gesture(
                           DragGesture()
                               .onChanged { value in
                                   let newAmount = (value.translation.width / geometry.size.width) * maxAmount
                                   amount = min(max(amount + newAmount, 1), maxAmount)
                               }
                       )
                   }
                   .frame(height: 300)
                   
                   Text("$\(Int(amount))")
                       .font(.largeTitle)
                       .padding()
               }
               .padding()
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
    CompassValuePicker(value: .constant(30))
}
