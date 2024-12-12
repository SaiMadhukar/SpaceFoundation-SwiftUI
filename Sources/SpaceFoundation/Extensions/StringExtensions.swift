//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/8/24.
//

import Foundation

extension String {
    
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
}

extension Optional {
    
    var isNil: Bool {
        self == nil
    }
}

extension Double {
    
    func toString() -> String {
        String(self)
    }
    
    func toDollars() -> String {
        "$ " + self.toString()
    }
}

extension Int {
    
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
