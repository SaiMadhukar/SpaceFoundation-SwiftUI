//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 12/10/24.
//

import SwiftUI
import Foundation


public enum Tools: String, Identifiable, CaseIterable {
    
    case calendar = "Calendar View"
    case luckyPot = "Lukcy Pot"
    case circleView = "Circle View"
    case capsuleView = "Capsule View"
    case buttonStyles = "Button Styles"
    case textStyles = "Text Styles"
    case inputFields = "Input Fields"
    
    public var name: String {
        self.rawValue
    }
    
    public var id: UUID {
        UUID()
    }
}

public struct SpacePlayground: View {
    
    private var all: [Tools] = Tools.allCases
    @State private var selectedTool: Tools?
    
    // Accessory Variables
    @State var special: SpecialText = SpecialText(font: .body.bold(), foregroundColor: .red.opacity(0.55), backgroundColor: .clear)
    @State private var selectedDate: Date = Date.now
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ForEach(all) { tool in
                NavigationLink(
                    destination: destinationFor(tool: tool),
                    label: {
                        Text(tool.name)
                            .textStyle(.headingSmall)
                            .foregroundColor(.white)
                            .frame(width: 300, height: 40)
                            .padding()
                            .background(Color.green.opacity(0.45))
                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                })
            }
        }
        .navigationBarTitle("Space Playground")
    }
    
    @ViewBuilder
    func destinationFor(tool: Tools) -> some View {
        switch tool {
        case .calendar:
            calendarView()
        case .luckyPot:
            LuckyPot()
        case .circleView:
             CircleView()
        case .buttonStyles:
            buttonStyles()
        case .capsuleView:
            CapsuleButton(title: "Good") {
                print("Good")
            }
        case .inputFields:
            textInput()
        default:
            EmptyView()
        }
    }
    
    func calendarView() -> some View {
        VStack {
            CalendarView(selectedDate: $selectedDate)
            
            Text("Selected Date: " + special.value(CalendarConfiguration.default.displayFormatter.string(from: selectedDate)))
                .bold()
            
            Spacer()
        }
    }
    
    @ViewBuilder
    func textInput() -> some View {
        VStack {
            Spacer()
            let usernameState: TextInputState = .init(text: "", title: "Username", type: .username, placeholder: "Enter username", scaleEffect: false, showCloaseButton: true, reqSecureField: false)
            
            TextInput(state: usernameState)
            
            Spacer()
        }
        .background(Color.linearGradient)
    }
    
    @ViewBuilder
    func buttonStyles() -> some View {
        VStack(spacing: 32) {
            SpaceButton(title: "Submit", configuration: .primary) {
                print("Submit")
            }
            .padding(.bottom, 16)
            
            SpaceButton(title: "Submit", configuration: .secondary) {
                print("Submit")
            }
            .padding(.bottom, 16)
            
            SpaceButton(title: "Submit", configuration: .tertiary) {
                print("Submit")
            }
            .padding(.bottom, 16)
            
            SpaceButton(title: "Submit", configuration: .plain) {
                print("Submit")
            }
            .padding(.bottom, 16)
        }
    }
}

#Preview {
    VStack {
        SpacePlayground()
    }
}
