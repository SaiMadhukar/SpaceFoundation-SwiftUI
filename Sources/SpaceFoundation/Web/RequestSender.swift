//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/1/25.
//

import Foundation
import SwiftUI

public protocol RequestSending {
    func sendRequest(with: URLRequest?, type: Decodable.Type) async throws -> Result<Decodable, RequestError>
}

public class RequestSender: RequestSending {
    
    private var session: URLSession
    
    public init(resolver: FoundationResolving) {
        self.session = resolver.resolveURLSession()
    }
    
    public func sendRequest(with request: URLRequest?, type: Decodable.Type) async throws -> Result<Decodable, RequestError> {
        
        guard let request = request else {
            return .failure(RequestError.invalidURL)
        }
        
        let (data, response) = try await session.data(for: request)
            
            
        guard let response = response as? HTTPURLResponse else {
            return .failure(RequestError.invalidResponse)
        }
        
        do {
            switch response.statusCode {
            case 200:
                let decoder = JSONDecoder()
                let structure = try decoder.decode(type, from: data)
                return .success(structure)
            case 400:
                return .failure(RequestError.UnknownError)
            case 404:
                return .failure(RequestError.invalidURL)
            case 500:
                return .failure(RequestError.internalServerError)
            default:
                return .failure(RequestError.UnknownError)
            }
        } catch {
            return .failure(RequestError.jsonDecodingError)
        }

    }
}
