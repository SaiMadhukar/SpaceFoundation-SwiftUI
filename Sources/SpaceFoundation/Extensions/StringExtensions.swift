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
        var repalce: String = self.replacingOccurrences(of: "$", with: "")
        return repalce.toDouble()
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
