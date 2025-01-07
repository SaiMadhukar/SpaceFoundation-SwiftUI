//
//  Calendar.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 12/10/24.
//

import Foundation
import CoreFoundation
import SwiftUI

public struct CalendarConfiguration: Sendable {
    
    var minDate: Date
    var maxDate: Date
    var displayedComponents: DatePickerComponents = [.date]
    
    public var displayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }
    
    public var formater: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    public static let `default`: CalendarConfiguration = CalendarConfiguration(
        minDate: Date.now,
        maxDate: Calendar.current.date(byAdding: .year, value: 100, to: Date.now) ?? Date.now
    )
}

public struct CalendarView: View {
    
    @State var configuration: CalendarConfiguration
    @Binding var selectedDate: Date
    
    public init(configuration: CalendarConfiguration = CalendarConfiguration.default, selectedDate: Binding<Date>) {
        self.configuration = configuration
        _selectedDate = selectedDate
    }
    
    public var body: some View {
        VStack {
            VStack {
                DatePicker("", selection: $selectedDate, in: configuration.minDate...configuration.maxDate, displayedComponents: configuration.displayedComponents)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .tint(.red.opacity(0.5))
                    .background(.gray.opacity(0.10))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .clipped()
            }
            .padding(16)
        }
    }
}


#Preview {
    let special: SpecialText = SpecialText(fontCategory: .headingSmall, foregroundColor: .red.opacity(0.55), backgroundColor: .clear)
    
    VStack {
        let selectedDate: Date = Date.now
        CalendarView(selectedDate: .constant(selectedDate))
        
        Text("Selected Date: " + special.value(CalendarConfiguration.default.displayFormatter.string(from: selectedDate)))
            .bold()
        
        Spacer()
    }
    .frame(width: 400, height: 800)
    .background(.blue.opacity(0.10))
}
