//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 12/10/24.
//

import SwiftUI
import Foundation


public enum Tools: String, Identifiable, CaseIterable {
    
    case spaceCharts = "Space Charts"
    case calendar = "Calendar View"
    case luckyPot = "Lukcy Pot"
    case circleView = "Circle View"
    case capsuleView = "Capsule View"
    case progtessView = "Progress View"
    

    case compass = "Compass"
    case inputFields = "Input Fields"
    case labels = "Labels"
    case buttonStyles = "Button Styles"
    case textStyles = "Text Styles"
    case gradientColors = "Gradient Colors"
    case spaceSlider = "Slider"
    
    public var name: String {
        self.rawValue
    }
    
    public var id: UUID {
        UUID()
    }
    
    public var isUIBase: Bool {
        switch self {
        case .labels, .inputFields, .textStyles, .buttonStyles, .gradientColors, .spaceSlider:
            return true
        default:
            return false
        }
    }
}

public struct SpacePlayground: View {
    
    @Environment(\.dismiss) var dismiss: DismissAction
    
    private var uiComponents = Tools.allCases.filter({ $0.isUIBase == true })
    private var specialComponents = Tools.allCases.filter({ $0.isUIBase == false })
    
    private let playgroundMock: PlaygroundMock = PlaygroundMock()
    @State private var selectedTool: Tools?
    @State private var amount: Double = 0.0
    
    // Accessory Variables
    @State var special: SpecialText = SpecialText(fontCategory: .body, foregroundColor: .red.opacity(0.55), backgroundColor: .clear)
    @State private var selectedDate: Date = Date.now
    
    // Input Fields
    @State var usernameState: TextInputState = .init(text: "", type: .username, placeholder: "Enter username", scaleEffect: false, showCloseButton: true, reqSecureField: false)
    @State var email: TextInputState = .init(text: "", type: .email, placeholder: "Enter email", scaleEffect: false, showCloseButton: true, reqSecureField: false)
    @State var password: TextInputState = .init(text: "", type: .password, placeholder: "Enter password", scaleEffect: false, showCloseButton: false, reqSecureField: true)
    
    @State private var value: Double = 50
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Section {
                        ForEach(specialComponents) { tool in
                            NavigationLink(
                                destination: destinationFor(tool: tool),
                                label: {
                                    SpaceLabel(title: tool.name, configuration: .primary)
                                        .frame(width: 300, height: 20)
                                        .padding()
                                        .background(Color.orange.opacity(0.45))
                                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                            })
                        }
                    } header: {
                        SpaceLabel(title: "Special Components", configuration: .primary)
                            .foreground(SpaceGradient.purpleGoldRadial.lStyle())
                            .frame(width: 300, height: 50, alignment: .leading)
                            .background(Color.white.opacity(0.45))
                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    }
                    
                    Section(content: {
                        ForEach(uiComponents) { tool in
                            NavigationLink(
                                destination: destinationFor(tool: tool),
                                label: {
                                    SpaceLabel(title: tool.name, configuration: .primary)
                                        .frame(width: 300, height: 20)
                                        .padding()
                                        .background(Color.green.opacity(0.45))
                                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                            })
                        }
                    }, header: {
                        SpaceLabel(title: "UI Components", configuration: .primary)
                            .foreground(SpaceGradient.purpleBlueLinear.lStyle())
                            .frame(width: 300, height: 50, alignment: .leading)
                            .background(Color.white.opacity(0.45))
                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    })
                }
            }
        }
        .navigationBarTitleDisplayMode(.automatic)
        
        .setNavigationBackButton {
            dismiss()
        }
    }
    
    @ViewBuilder
    func destinationFor(tool: Tools) -> some View {
        switch tool {
        case .labels:
            spaceLabels()
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
        case .spaceCharts:
            let viewModel: SpaceChartViewModel = SpaceChartViewModel(data: playgroundMock.chartMock)
            SpaceChart(viewModel: viewModel, grouping: .constant(.day))
        case .gradientColors:
            gradeintView()
        case .textStyles:
            textStyles()
        case .compass:
            Compass(value: $value)
        case .spaceSlider:
            SpaceSlider(amount: $amount, maxAmount: 100)
        case .progtessView:
            SpaceProgressView()
        }
    }
    
    func spaceLabels() -> some View {
        VStack {
            SpaceLabel(title: "Good Morning - Primary", configuration: .primary)
            
            SpaceLabel(title: "Good Morning - Secondary", configuration: .secondary)
            
            SpaceLabel(title: "Good Morning - Tertiary", configuration: .secondary)
            
            SpaceLabel(title: "Good Morning - Plain", configuration: .plain)
        }
    }
    
    func textStyles() -> some View {
        VStack {
            Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                .modifier(FontStyleModifier(category: .headingLarge, weight: .bold))
            
            Divider()
            
            Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                .modifier(FontStyleModifier(category: .subheading, weight: .bold))
            
            Divider()
            
            Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                .modifier(FontStyleModifier(category: .bodyMedium, weight: .bold))
            
            Divider()
            
            Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                .modifier(FontStyleModifier(category: .spaceFont, weight: .regular))
        }
    }
    
    
    func gradeintView() -> some View {
        ScrollView {
            HStack {
                Circle()
                    .fill(SpaceGradient.blueLightRadial.rStyle())
                    .frame(width: 200, height: 200)
                    .shadow(color: .black.opacity(0.25) ,radius: 4)
                    
                Circle()
                    .fill(SpaceGradient.greenOrangeLinear.lStyle())
                    .frame(width: 150, height: 150)
                    .shadow(color: .black.opacity(0.25) ,radius: 4)
            }
            .padding(.horizontal, 16)
          
            HStack {
                Circle()
                    .fill(SpaceGradient.goldLightRadial.rStyle())
                    .frame(width: 200, height: 200)
                    .shadow(color: .black.opacity(0.25) ,radius: 4)
                
                
                Circle()
                    .fill(SpaceGradient.greenOrangeLinear.rStyle())
                    .frame(width: 150, height: 150)
                    .shadow(color: .black.opacity(0.25) ,radius: 4)
            }
            .padding(.horizontal, 16)
            
            HStack {
                Circle()
                    .fill(SpaceGradient.greenOrangeLinear.rStyle())
                    .frame(width: 200, height: 200)
                    .shadow(color: .black.opacity(0.25) ,radius: 4)
                
                Circle()
                    .fill(SpaceGradient.purpleBlueLinear.rStyle())
                    .frame(width: 150, height: 150)
                    .shadow(color: .black.opacity(0.25) ,radius: 4)
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 800, alignment: .center)
    }
    
    func calendarView() -> some View {
        VStack {
            CalendarView(selectedDate: $selectedDate)
            
            Text("Selected Date: " + special.value(CalendarConfiguration.default.displayFormatter.string(from: selectedDate)))
                .bold()
            
            Spacer()
        }
    }
    
    func textInput() -> some View {
        VStack(spacing: 16) {
            Spacer()
           
            InputField(state: usernameState)

            InputField(state: email)
            
            InputField(state: password)
            
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


struct PlaygroundMock {
    
    let chartMock: [MockChartModel] = .init([
        MockChartModel(x: "Jan", y: 1000),
        MockChartModel(x: "Feb", y: 1600),
        MockChartModel(x: "Mar", y: 2000),
        MockChartModel(x: "Apr", y: 2200),
        MockChartModel(x: "May", y: 1200)
    ])
    
    let usernameState: TextInputState = .init(text: "", type: .username, placeholder: "Enter username", scaleEffect: false, showCloseButton: true, reqSecureField: false)
}

