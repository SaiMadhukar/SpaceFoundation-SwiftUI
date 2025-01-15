//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/1/25.
//

import Foundation
import SwiftUI

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public class RequestBuilder {
    
    private struct RequestParams {
        static let contentType = "application/json"
        static let userAgent = "iOS"
        static let appName = "GrowSpace"
        static let userAgentKey = "User-Agent"
        static let appNameKey = "AppName"
        static let contentTypeKey = "Content-Type"
    }
    
    private var request: URLRequest
    
    public init(url: URL) {
        self.request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue(RequestParams.contentType, forHTTPHeaderField: RequestParams.contentTypeKey)
        request.setValue(RequestParams.userAgent, forHTTPHeaderField: RequestParams.userAgentKey)
        request.setValue(RequestParams.appName, forHTTPHeaderField: RequestParams.appNameKey)
    }
    
    
    public func setMethod(_ method: HTTPMethod) -> Self {
        self.request.httpMethod = method.rawValue
        return self
    }
    
    public func withHeaders(headers: [String: String]) -> Self {
        headers.forEach { (key, value) in
            self.request.setValue(value, forHTTPHeaderField: key)
        }
        return self
    }
    
    public func withBody(body: Data?) -> Self {
        self.request.httpBody = body
        return self
    }
    
    public func withQueryParams(params: [String: String]) -> Self {
        let urlComponents = URLComponents(string: request.url?.absoluteString ?? "")
        var queryItems = [URLQueryItem]()
        params.forEach { (key, value) in
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        request.url = urlComponents?.url
        return self
    }
    
    public func build() -> URLRequest {
        return request
    }
}
