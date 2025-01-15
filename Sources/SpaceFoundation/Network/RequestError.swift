//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/1/25.
//

import Foundation

public enum RequestError: Error {
    case invalidURL
    case invalidResponse
    case failedRequest
    case jsonDecodingError
    case UnknownError
    case internalServerError
    case NoData
}
