//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/5/25.
//

import Foundation
import SwiftUI

struct SpaceToggleModifier: ViewModifier {
    let isBordered: Bool
    func body(content: Content) -> some View {
        if isBordered {
            content.buttonStyle(.bordered)
        } else {
            content.buttonStyle(.plain)
        }
    }
}

public struct SpaceToggle: View {
    
    @Binding var grouping: ChartGrouping
    
    public init(binding: Binding<ChartGrouping>) {
        _grouping = binding
    }
    
    public var body: some View {
        HStack{
            Spacer()
            Button("Day") { grouping = .day}
                .tint(SpaceColors.green55)
                .modifier(SpaceToggleModifier(isBordered: grouping == .day))
            Spacer()
            
            Button("Month") {grouping = .month }
                .tint(SpaceColors.green55)
                .modifier(SpaceToggleModifier(isBordered: grouping == .month))
            Spacer()
            
            Button("Year") {grouping = .year}
                .tint(SpaceColors.green55)
                .modifier(SpaceToggleModifier(isBordered: grouping == .year))
            Spacer()
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    VStack {
        @State var binding: ChartGrouping = .day
        SpaceToggle(binding: $binding)
    }
    .frame(width: 400, height: 100)
}
