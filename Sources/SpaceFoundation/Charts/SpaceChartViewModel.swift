//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 12/14/24.
//

import Foundation
import Charts

public struct ChartModel: Identifiable, Sendable {
    
    let x: String
    let y: Double
    
    public var id: UUID = UUID()
}


public class SpaceChartViewModel: ObservableObject {
    
    @Published var selected: ChartModel?
    
    var barWidth: MarkDimension = .init(integerLiteral: 20)
    var data: [ChartModel]
    
    public init(data: [ChartModel] = []) {
        self.data = data
    }
}


public struct MockData {
    
    let chartValues = [
        ChartModel(x: "Jan", y: 1000),
        ChartModel(x: "Feb", y: 1600),
        ChartModel(x: "Mar", y: 2000),
        ChartModel(x: "Apr", y: 2200),
        ChartModel(x: "May", y: 1200)
    ]
}

