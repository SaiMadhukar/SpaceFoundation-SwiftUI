//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 12/14/24.
//

import Foundation
import Charts

public enum ChartGrouping {
    case day, month, year
}

public protocol ChartModelProtocol: Identifiable {
    var xLabel: String { get }
    var yLabel: Double { get }
    
    var date: String? { get }
    var monthDate: String? { get }
    var yearDate: String? { get }
}

public extension ChartModelProtocol {
    func getXAxis(group: ChartGrouping) -> String {
        switch group {
        case .day:
            return date ?? ""
        case .month:
            return monthDate ?? ""
        case .year:
            return yearDate ?? ""
        }
    }
}

public class SpaceChartViewModel<ChartModel: ChartModelProtocol>: ObservableObject {
    
    @Published public var selectedModel: [ChartModel]?
    @Published public var selectedRowMark: (String, Double)?
    
    var barWidth: MarkDimension = .init(integerLiteral: 20)
    @Published var data: [ChartModel]
    
    public init(data: [ChartModel] = []) {
        self.data = data
    }
    
    public func setData(data: [ChartModel]) {
        self.data = data
    }
}


public struct MockChartModel: ChartModelProtocol, Sendable {
    public var id: UUID = UUID()
    
    public let xLabel: String
    public let yLabel: Double
    
    public var date: String?
    public var monthDate: String?
    public var yearDate: String?
    
    public init(x: String, y: Double) {
        self.xLabel = x
        self.yLabel = y
    }
}

public struct MockData {
    
    public static let chartValues = [
        MockChartModel(x: "Jan", y: 1000),
        MockChartModel(x: "Feb", y: 1600),
        MockChartModel(x: "Mar", y: 2000),
        MockChartModel(x: "Apr", y: 2200),
        MockChartModel(x: "May", y: 1200)
    ]
}
