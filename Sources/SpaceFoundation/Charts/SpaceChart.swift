//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 12/14/24.
//

import SwiftUI
import Charts

struct SpaceChart: View {
    
    @StateObject private var viewModel: SpaceChartViewModel
    
    init(viewModel: SpaceChartViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Chart {
                ForEach(viewModel.data) { model in
                    BarMark(x: .value("X", model.x),
                            y: .value("Y", model.y),
                            width: viewModel.barWidth)
                        .foregroundStyle(Color.linearGradient)
                }
    
                if let selected: ChartModel = viewModel.selected {
                    RuleMark(x: .value("X", selected.x))
                                .annotation(position: .top, alignment: .top) {
                                    VStack {
                                        Text(selected.y.description)
                                            .foregroundStyle(Color.linearGradient)
                                    }
                                }
                                .lineStyle(.init(lineWidth: 1, lineCap: .round, dash: [5]))
                                .foregroundStyle(.black.opacity(0.3))
                }
                
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
        
    }
    
    private func updateSelectedMonth(at location: CGPoint, proxy: ChartProxy, geometry: GeometryProxy) {
        
        let xPosition = location.x - geometry[proxy.plotAreaFrame].origin.x
        guard let month: String = proxy.value(atX: xPosition) else {
            return
        }
        viewModel.selected = viewModel.data.filter({ $0.x == month }).first
    }
}




#Preview {
    let viewModel: SpaceChartViewModel = SpaceChartViewModel(data: MockData().chartValues)
    SpaceChart(viewModel: viewModel)
}

