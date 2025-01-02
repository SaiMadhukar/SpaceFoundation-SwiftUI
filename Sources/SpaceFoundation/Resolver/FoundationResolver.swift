//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/1/25.
//

import Foundation


public protocol FoundationResolving {
    
    func resolveRequestSending() -> RequestSending
    
    func resolveURLSession() -> URLSession
}

extension FoundationResolving {
    
    public func resolveRequestSending() -> RequestSending {
        RequestSender(resolver: self)
    }
    
    public func resolveURLSession() -> URLSession {
        URLSession(configuration: .default)
    }
}
