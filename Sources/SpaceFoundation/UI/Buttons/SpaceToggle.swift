//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/5/25.
//

import Foundation
import SwiftUI

public protocol SwitchOptions: Identifiable, CaseIterable, Equatable, Hashable {
    var rawValue: String { get }
    var id: Int { get }
}

public enum DateRanges: String, SwitchOptions {
    case day = "Day"
    case month = "Month"
    case quarter = "Quarter"
    case year = "Year"
    
    public var id: Int {
        switch self {
        case .day:
            return 1
        case .month:
            return 2
        case .quarter:
            return 3
        case .year:
            return 4
        }
    }
}


public struct SpaceSwitchBar<S: SwitchOptions>: View {
    
    private var options: [S]
    @Binding private var selection: S
    @State private var animated: Bool = false
    @State private var oldOffSetX: Double = .zero
    private var height: CGFloat
    private var width: CGFloat
    private var cornerRadius: CGFloat = 20
    private var selectionColor: Color
    
    public init(selection: Binding<S>, options: [S], height: CGFloat = 36, width: CGFloat = 100, selectionColor: Color = SpaceColors.green75) {
        self.options = options
        _selection = selection
        self.height = height
        self.width = width
        self.selectionColor = selectionColor
    }
    
    public var body: some View {
        contentView
            .clipped()
    }
    
    var contentView: some View {
        HStack(spacing: 16) {
            ForEach(options) { option in
                Button {
                    self.animated = true
                    self.selection = option
                } label: {
                    Text(option.rawValue)
                        .spaceFontStyle(category: .body,
                                        weight: .regular,
                                        color:  selection == .some(option) ? SpaceColors.white : SpaceColors.blue100)
                        .scaledToFit()
                }
                .frame(width: width , height: height)
            }
        }
        .background(
            GeometryReader { proxy in
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(SpaceColors.gray25)
                    .background {
                        let pillSize: Double = Double(proxy.size.width / Double(options.count))
                        let newOffSetX = Double(selection.id - 2) * pillSize
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(selectionColor)
                            .frame(width: pillSize, height: height)
                            .offset(x: animated ? oldOffSetX: newOffSetX, y: 0)
                            .onChange(of: animated, perform: { newValue in
                                oldOffSetX = newOffSetX
                            })
                    }
            }
        )
        .onChange(of: selection, perform:  { newValue in
            withAnimation(.spring(duration: 1)) {
                animated.toggle()
            }
        })
        .padding(.horizontal, 16)
    }
}

#Preview {
    VStack {
        @State var binding: ChartGrouping = .day
        SpaceSwitchBar(selection: $binding, options: ChartGrouping.allCases)
            
        Spacer()
    }
    .frame(width: 400, height: 400)
}
