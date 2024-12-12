//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 12/10/24.
//

import Foundation
import SwiftUI

public struct SpaceCalendarStyle: DatePickerStyle {
    
    var selectionColor: Color
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

struct SpaceCalendarStyle_Previews: PreviewProvider {
    static var previews: some View {
        DatePicker("Date", selection: .constant(Date()), displayedComponents: .date)
            .datePickerStyle(SpaceCalendarStyle(selectionColor: .blue))
    }
}
