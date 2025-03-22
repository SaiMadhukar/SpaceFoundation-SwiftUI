//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 3/22/25.
//

import Foundation
import SwiftUI

public enum SpaceTabItem: String, CaseIterable, Identifiable, CustomStringConvertible, Equatable {
    case home = "house.fill"
    case saved = "heart.fill"
    case profile = "person.fill"
    
    public var id: String {
        return self.rawValue
    }
    
    public var description: String {
        return self.rawValue
    }
    
    public static func == (lhs: SpaceTabItem, rhs: SpaceTabItem) -> Bool {
        return lhs.id == rhs.id
    }
}

public struct SpaceTabBar<CustomTab: Identifiable & CustomStringConvertible & Equatable>: View {
    @Binding var selectedTab: CustomTab
    @State var tabValues: [CustomTab]
    @State var animated: Bool = false
    
    public init(reqTabs: [CustomTab], selectedTab: Binding<CustomTab>) {
        self.tabValues = reqTabs
        _selectedTab = selectedTab
    }
    
    public var body: some View {
        HStack {
            ForEach(tabValues, id: \.id) { tab in
                Spacer()
                Button(action: {
                    selectedTab = tab
                    withAnimation(.spring(duration: 1)) {
                        animated.toggle()
                    }
                }) {
                    VStack {
                        Image(systemName: tab.description)
                            .font(.system(size: 24))
                            .scaleEffect(animated && selectedTab == tab ? 1.2 : 1)
                            .shadow(radius: animated && selectedTab == tab ? 4 : 0)
                            .foregroundColor(selectedTab == tab ? SpaceColors.yellow90 : SpaceColors.white)
                            .padding(8)
                            .background(selectedTab == tab ? SpaceColors.primary : SpaceColors.white)
                            .clipShape(Circle())
                    }
                }
                Spacer()
            }
        }
        .padding(.vertical, 8)
        .background(Color.primary)
        .cornerRadius(32)
        .padding(.horizontal, 24)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}


struct ContentView: View {
    @State private var selectedTab: SpaceTabItem = .home
    
    var body: some View {
        VStack {
            Spacer()
            SpaceTabBar(reqTabs: SpaceTabItem.allCases, selectedTab: $selectedTab)
        }
        .background(SpaceColors.white.ignoresSafeArea())
    }
}

#Preview {
    ContentView()
}
