//
//  File 2.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/23/24.
//

import Foundation


public enum FieldType: Int {
    case username
    case password
    case phone
    case `default`
}

class TextInputValidator: NSObject {
    private struct Constants {
        static let alphabets: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        static let specialChar: String = "+_@.-"
        static let numeric: String = "0123456789"
        static let emailRegEx = "[A-Z0-9a-z_%+-]+@[A-Za-z0-9.-]+\\|.[A-Za-z]{2, 64}"
        
        static let numericCharacterSet: CharacterSet = CharacterSet(charactersIn: numeric)
        static let alphaNumericCharacterSet: CharacterSet = CharacterSet(charactersIn: alphabets + numeric)
        static let specialAlphaNumericCharacterSet: CharacterSet = CharacterSet(charactersIn: alphabets + numeric + specialChar)
    }
    
    func checkValidity(text: String, textFieldType: FieldType) -> Bool {
        checkMinLength(text, textFieldType: textFieldType) &&
        checkMaxLength(text, textFieldType: textFieldType) &&
        check(text, textFieldType: textFieldType)
    }
    
    func checkMaxLength(_ text: String, textFieldType: FieldType) -> Bool {
        switch textFieldType {
        case .username:
            return text.checkMaxLength(max: 16)
        case .password:
            return text.checkMaxLength(max: 16)
        case .phone:
            return text.checkMaxLength(max: 10)
        case .default:
            return text.checkMaxLength(max: 16)
        }
    }
    
    func checkMinLength(_ text: String, textFieldType: FieldType) -> Bool {
        switch textFieldType {
        case .username:
            return text.checkMinLength(min: 8)
        case .password:
            return text.checkMinLength(min: 8)
        case .phone:
            return text.checkMinLength(min: 10)
        case .default:
            return text.checkMinLength(min: 2)
        }
    }
    
    func check(_ text: String, textFieldType: FieldType) -> Bool {
        switch textFieldType {
        case .username:
            return checkSpecialAlphaNumericCharacters(text: text)
        case .password:
            return checkSpecialAlphaNumericCharacters(text: text)
        case .phone:
            return checkNumeric(text: text)
        case .default:
            return true
        }
    }
}

extension TextInputValidator {
    
    func checkNumeric(text: String) -> Bool {
        let inputCharacterSet: CharacterSet = CharacterSet(charactersIn: text)
        return Constants.numericCharacterSet.isSuperset(of: inputCharacterSet)
    }
    
    func checkSpecialAlphaNumericCharacters(text: String) -> Bool {
        let inputCharacterSet: CharacterSet = CharacterSet(charactersIn: text)
        return Constants.specialAlphaNumericCharacterSet.isSuperset(of: inputCharacterSet)
    }
    
    func checkAlphaNumeric(text: String) -> Bool {
        let inputCharacterSet: CharacterSet = CharacterSet(charactersIn: text)
        return Constants.alphaNumericCharacterSet.isSuperset(of: inputCharacterSet)
    }
}
