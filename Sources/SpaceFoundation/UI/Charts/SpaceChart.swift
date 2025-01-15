//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 12/14/24.
//

import SwiftUI
import Charts

public struct SpaceChart<ChartModel: ChartModelProtocol>: View {
    
    @StateObject private var viewModel: SpaceChartViewModel<ChartModel>
    @Binding private var grouping: ChartGrouping
    
    public init(viewModel: SpaceChartViewModel<ChartModel>, grouping: Binding<ChartGrouping>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _grouping = grouping
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            Chart {
                ForEach(viewModel.data) { model in
                    let xAxis: String = model.getXAxis(group: grouping)
                    BarMark(x: .value("X", xAxis),
                            y: .value("Y", model.yLabel),
                            width: viewModel.barWidth)
                        .foregroundStyle(SpaceGradient.purpleBlueLinear.lStyle())
                }
    
                if let selectedRowMark = viewModel.selectedRowMark {
                    RuleMark(x: .value("X", selectedRowMark.0))
                                .annotation(position: .top, alignment: .top) {
                                    VStack {
                                        Text("$ \(Int(selectedRowMark.1))")
                                            .foregroundStyle(SpaceGradient.purpleBlueLinear.lStyle())
                                    }
                                }
                                .lineStyle(.init(lineWidth: 1, lineCap: .round, dash: [5]))
                                .foregroundStyle(.black.opacity(0.3))
                }
            }
            .chartLegend(.hidden)
            .chartXAxis {
                AxisMarks(position: .bottom) { _ in
                    AxisGridLine().foregroundStyle(.clear)
                    AxisTick().foregroundStyle(.clear)
                    AxisValueLabel()
                }
            }
            .frame(height: 300)
            .padding()
            .chartOverlay { proxy in
                    GeometryReader { geometry in
                        ZStack(alignment: .top) {
                            Rectangle().fill(.clear).contentShape(Rectangle())
                                .onTapGesture { location in
                                    updateSelectedMonth(at: location, proxy: proxy, geometry: geometry)
                                }
                        }
                    }
                }
            SpaceToggle(binding: $grouping)
        }
        .onChange(of: grouping) { newValue in
            viewModel.selectedRowMark = nil
        }
    }
    
    private func updateSelectedMonth(at location: CGPoint, proxy: ChartProxy, geometry: GeometryProxy) {
        
        let xPosition = location.x - geometry[proxy.plotAreaFrame].origin.x
        guard let xlabel: String = proxy.value(atX: xPosition) else {
            return
        }
        var filteredGroup: [ChartModel]?
        switch grouping {
        case .day:
            filteredGroup = viewModel.data.filter({ $0.date == xlabel })
        case .month:
            filteredGroup = viewModel.data.filter({ $0.monthDate == xlabel })
        case .year:
            filteredGroup = viewModel.data.filter({ $0.yearDate == xlabel })
        }
        
        if let models: [ChartModel] = filteredGroup, filteredGroup?.count ?? 0 > 0 {
            let selectedY: Double = models.reduce(0, { $0 + $1.yLabel })
            viewModel.selectedModel = filteredGroup
            viewModel.selectedRowMark = (xlabel, selectedY)
        } else {
            viewModel.selectedModel = nil
            viewModel.selectedRowMark = nil
        }
    }
}


#Preview {
    let viewModel: SpaceChartViewModel = SpaceChartViewModel(data: MockData.chartValues)
    @State var grouping: ChartGrouping = .day
    SpaceChart(viewModel: viewModel, grouping: $grouping)
}

