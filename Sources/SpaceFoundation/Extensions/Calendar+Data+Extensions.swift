//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 3/1/25.
//

import Foundation
import SwiftUI

private let dateFormatter = DateFormatter()
private let calendar: Calendar = Calendar(identifier: .iso8601)

public extension Date {
    
    func calendarDates() -> [Date] {
        guard let firstDayOfMonth: Date = calendar.dateInterval(of: .month, for: self)?.start else { return [] }
        let daysInMonth = calendar.range(of: .day, in: .month, for: self)!
        var days: [Date] = []
        
        for day in 0..<daysInMonth.count {
            guard let currentDay = calendar.date(byAdding: .day, value: day, to: firstDayOfMonth) else { continue }
            days.append(currentDay)
        }
        
        return days
    }
    
    func addMonth(n: Int) -> Date {
        calendar.date(byAdding: .month, value: n, to: self)!
    }
    
    func addDays(n: Int) -> Date {
        calendar.date(byAdding: .day, value: n, to: self)!
    }
    
    func addWeeks(n: Int) -> Date {
        let days = n * 7
        return calendar.date(byAdding: .day, value: days, to: self)!
    }
    
    func addYear(n: Int) -> Date {
        calendar.date(byAdding: .year, value: n, to: self)!
    }
        
    var firstDayOfMonth: Date? {
        calendar.dateInterval(of: .month, for: self)?.start
    }
    
    var daysInMonth: Range<Int> {
        calendar.range(of: .day, in: .month, for: self)!
    }
    
    var startDayWeek: WeekDays? {
        if let firstDay: Date = firstDayOfMonth {
            dateFormatter.dateFormat = "EEE"
            let value = dateFormatter.string(from: firstDay)
            return WeekDays(rawValue: value)
        }
       return nil
    }
    
    var weekDay: String {
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self)
    }
    
    var day: String {
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
}

public enum WeekDays: String, CaseIterable {
    
    case sun = "Sun"
    case mon = "Mon"
    case tue = "Tue"
    case wed = "Wed"
    case thu = "Thu"
    case fri = "Fri"
    case sat = "Sat"
    
    public var value: Int {
        switch self {
        case .sun:
            return 1
        case .mon:
            return 2
        case .tue:
            return 3
        case .wed:
            return 4
        case .thu:
            return 5
        case .fri:
            return 6
        case .sat:
            return 7
        }
    }
}

#Preview {
    
    let date: Date = Date.now
    let calendar = Calendar.current
    ScrollView{
        VStack {
            ForEach(date.calendarDates(), id: \.self) { date in
                LazyHGrid(rows: [.init(.adaptive(minimum: 50))]) {
                    let stringDate = date.formatted(date: .numeric, time: .omitted)
                    Text(date.day)
                        .spaceFontStyle(category: .bodyLarge)
                        .foregroundColor(.black)
                }
            }
        }
    }
    
    .background(Color.white)
}
