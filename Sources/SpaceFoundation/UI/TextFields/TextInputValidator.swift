//
//  File 2.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 11/23/24.
//

import Foundation
import SwiftUI


public enum FieldType: Int {
    case username
    case password
    case phone
    case email
    case newPassword
    case amount
    case singleDigitNumber
    case `default`
}

class TextInputValidator: NSObject {
    private struct Constants {
        static let alphabets: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        static let specialChar: String = "+_@.-*"
        static let numeric: String = "0123456789"
        static let passwordSpecialChar: String = "!@#$"
        static let emailRegEx = "[A-Z0-9a-z_%+-]+@[A-Za-z0-9.-]+\\|.[A-Za-z]{2, 64}"
        
        static let numericCharacterSet: CharacterSet = CharacterSet(charactersIn: numeric)
        static let alphaNumericCharacterSet: CharacterSet = CharacterSet(charactersIn: alphabets + numeric)
        static let specialAlphaNumericCharacterSet: CharacterSet = CharacterSet(charactersIn: alphabets + numeric + specialChar)
    }
    
    func autoCaptialization(for type: FieldType) -> TextInputAutocapitalization {
        switch type {
        case .username:
            return .words
        default:
            return .never
        }
    }
    
    func checkStateValidations(text: String, textFieldType: FieldType) -> Bool {
        checkMinLength(text, textFieldType: textFieldType) &&
        checkMaxLength(text, textFieldType: textFieldType) &&
        checkValidations(text, textFieldType: textFieldType)
    }
    
    func checkMaxLength(_ text: String, textFieldType: FieldType) -> Bool {
        switch textFieldType {
        case .username:
            return text.checkMaxLength(max: 16)
        case .password, .newPassword:
            return text.checkMaxLength(max: 32)
        case .email:
            return text.checkMaxLength(max: 64)
        case .phone:
            return text.checkMaxLength(max: 10)
        case .amount:
            return text.checkMaxLength(max: 3)
        case .singleDigitNumber:
            return text.checkMaxLength(max: 2)
        case .default:
            return text.checkMaxLength(max: 16)
        }
    }
    
    func checkMinLength(_ text: String, textFieldType: FieldType) -> Bool {
        switch textFieldType {
        case .username:
            return text.checkMinLength(min: 6)
        case .password, .newPassword:
            return text.checkMinLength(min: 8)
        case .email:
            return text.checkMinLength(min: 6)
        case .phone:
            return text.checkMinLength(min: 10)
        case .amount:
            return text.checkMinLength(min: 1)
        case .singleDigitNumber:
            return text.checkMaxLength(max: 1)
        case .default:
            return text.checkMinLength(min: 2)
        }
    }
    
    func checkAllowedChar(_ text: String, textFieldType: FieldType) -> Bool {
        switch textFieldType {
        case .username:
            return checkSpecialAlphaNumericCharacters(text: text)
        case .password, .newPassword:
            return checkSpecialAlphaNumericCharacters(text: text)
        case .phone:
            return checkNumeric(text: text)
        case .email:
            return checkSpecialAlphaNumericCharacters(text: text)
        case .amount:
            return checkNumeric(text: text)
        case .singleDigitNumber:
            return checkNumeric(text: text)
        case .default:
            return true
        }
    }
    
    func checkValidations(_ text: String, textFieldType: FieldType) -> Bool {
        switch textFieldType {
        case .username:
            return validateUsername(text)
        case .password, .newPassword:
            return validatePassword(text: text)
        case .phone:
            return validatePhoneNumber(text)
        case .email:
            return validateEmail(text: text)
        case .amount:
            return validateAmount(text: text)
        case .singleDigitNumber:
            return validateSingleDigit(text: text)
        case .default:
            return true
        }
    }
}

extension TextInputValidator {
    
    func checkNumeric(text: String) -> Bool {
        let regex = "^[0-9]+$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text)
    }
    
    func checkSpecialAlphaNumericCharacters(text: String) -> Bool {
        let regex = "^[a-zA-Z0-9+_@.-]+$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text)
    }
    
    func checkPasswordSpecialAlphaNumericCharacters(text: String) -> Bool {
        let regex = "^[a-zA-Z0-9!@#$]+$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text)
    }
    
    func checkAlphaNumeric(text: String) -> Bool {
        let regex = "^[a-zA-Z0-9]+$" // Example regex: only alphanumeric characters
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text)
    }
    
    func validateEmail(text: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text)
    }
    
    func validatePassword(text: String) -> Bool {
        let regex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[!@#$*]).{8,32}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text)
    }
    
    func validateUsername(_ username: String) -> Bool {
        let regex = "^[a-zA-Z0-9@_\\-+.]{6,16}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: username)
    }
    
    func validatePhoneNumber(_ phone: String) -> Bool {
        let regex = "^[0-9]{10}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: phone)
    }
    
    func validateAmount(text: String) -> Bool {
        let regex = "^[0-9]+$"
        guard let double: Double = Double(text), double < 333.0 else { return false }
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text)
    }
    
    func validateSingleDigit(text: String) -> Bool {
        guard let intValue: Int = Int(text) else { return false }
        return text.count == 1
    }
}
