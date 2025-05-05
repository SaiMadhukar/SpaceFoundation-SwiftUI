//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 3/22/25.
//

import Foundation
import SwiftUI

public enum SpaceTabItem: String, RawRepresentable, CaseIterable, Identifiable, CustomStringConvertible, Equatable {
    case home = "Home"
    case explore = "Explore"
    case favourite = "Favourite"
    case profile = "Profile"
    
    public var id: String {
        return self.rawValue
    }
    
    public var description: String {
        switch self {
        case .home:
            return "house.fill"
        case .explore:
            return "sparkle.magnifyingglass"
        case .favourite:
            return "heart.fill"
        case .profile:
            return "person.fill"
        }
    }
    
    public static func == (lhs: SpaceTabItem, rhs: SpaceTabItem) -> Bool {
        return lhs.id == rhs.id
    }
}

public struct SpaceTabBar<CustomTab: Identifiable & RawRepresentable & CustomStringConvertible & Equatable>: View {
    @Binding var selectedTab: CustomTab
    @State var tabValues: [CustomTab]
    @State var animated: Bool = false
    @State var height: CGFloat
    
    public init(reqTabs: [CustomTab], selectedTab: Binding<CustomTab>, height: CGFloat = 44) {
        self.tabValues = reqTabs
        _selectedTab = selectedTab
        self.height = height
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            ForEach(tabValues, id: \.id) { tab in
                Spacer()
                Button(action: {
                    selectedTab = tab
                    withAnimation(.easeInOut(duration: 1.0)) {
                        animated.toggle()
                    }
                }) {
                    Image(systemName: tab.description)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .scaleEffect(animated && selectedTab == tab ? 1.05 : 1)
                        .shadow(radius: animated && selectedTab == tab ? 4 : 0)
                        .foregroundColor(selectedTab == tab ? SpaceColors.yellow75 : SpaceColors.white)
                }
                Spacer()
            }
        }
        .frame(height: height)
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
