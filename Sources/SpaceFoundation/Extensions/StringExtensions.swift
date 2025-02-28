//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/8/24.
//

import Foundation

private let cal = Calendar.current
private let dateFormatter = DateFormatter()

public extension String {
    
    var empty: Self { "" }
    
    func isEmpty() -> Bool {
        self == ""
    }
    
    func toInt() -> Int? {
        Int(self)
    }
    
    func toDouble() -> Double? {
        Double(self)
    }
    
    func dollarValue() -> Double? {
        let repalce: String = self.replacingOccurrences(of: "$", with: "")
        return repalce.toDouble()
    }
    
    func currency() -> String? {
        let repalce: String = self.replacingOccurrences(of: "$", with: "")
        return repalce.toDouble()?.toDollars()
    }
}

public extension Optional {
    
    var isNil: Bool {
        self == nil
    }
}

public extension Double {
    
    func toString() -> String {
        let parsed: String = "\(self.intValue)"
        return String(parsed)
    }
    
    func toDollars() -> String {
        "$ " + self.toString()
    }
    
    var intValue: Int {
        Int(self)
    }
}

public extension Int {
    
    func toString() -> String {
        String(self)
    }
    
    func toDollars() -> String {
        "$ " + self.toString()
    }
}


public extension String {
    
    private struct Constants {
        static let alphabets: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        static let specialChar: String = "+_@.-"
        static let numeric: String = "0123456789"
        static let emailRegEx = "[A-Z0-9a-z_%+-]+@[A-Za-z0-9.-]+\\|.[A-Za-z]{2, 64}"
        
        static let numericCharacterSet: CharacterSet = CharacterSet(charactersIn: numeric)
        static let alphaNumericCharacterSet: CharacterSet = CharacterSet(charactersIn: alphabets + numeric)
        static let specialAlphaNumericCharacterSet: CharacterSet = CharacterSet(charactersIn: alphabets + numeric + specialChar)
    }
    
    func checkNumeric() -> Bool {
        let inputCharacterSet: CharacterSet = CharacterSet(charactersIn: self)
        return Constants.numericCharacterSet.isSuperset(of: inputCharacterSet)
    }
    
    func specialCharacters() -> Bool {
        let inputCharacterSet: CharacterSet = CharacterSet(charactersIn: self)
        return Constants.specialAlphaNumericCharacterSet.isSuperset(of: inputCharacterSet)
    }
    
    func checkAlphaNumeric() -> Bool {
        let inputCharacterSet: CharacterSet = CharacterSet(charactersIn: self)
        return Constants.alphaNumericCharacterSet.isSuperset(of: inputCharacterSet)
    }
    
    func checkLength(min: Int, max: Int) -> Bool {
        self.count >= min && self.count < max
    }
    
    func checkMaxLength(max: Int) -> Bool {
        self.count < max
    }
    
    func checkMinLength(min: Int) -> Bool {
        self.count >= min
    }
}

public extension Date {
    var year: Int {
        return cal.component(.year, from: self)
    }
    var week: Int {
        return cal.component(.weekOfYear, from: self)
    }
    var weekAndYear: DateComponents {
        return cal.dateComponents([.weekOfYear, .year], from: self)
    }
    
    var startOfWeek: Date {
        let components = cal.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        return cal.date(from: components)!
    }
    
    var dayFormatted: String? {
        dateFormatter.dateFormat = "dd-MMM"
        return dateFormatter.string(from: self)
    }
    
    var monthFormatted: String? {
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self)
    }
    
    var yearFormatted: String? {
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: self)
    }
    
    var monthYearFormatted: String? {
        dateFormatter.dateFormat = "MMM YYYY"
        return dateFormatter.string(from: self)
    }
    
}

public extension String {
    
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self)
    }
}
