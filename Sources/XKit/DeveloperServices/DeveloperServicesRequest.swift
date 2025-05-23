//
//  DeveloperServicesRequest.swift
//  Supercharge
//
//  Created by Kabir Oberai on 24/07/19.
//  Copyright © 2019 Kabir Oberai. All rights reserved.
//

import Foundation

public struct EmptyResponse: Decodable, Sendable {}

public protocol DeveloperServicesRequest: Sendable {

    associatedtype Response: Decodable, Sendable
    associatedtype Value: Sendable

    var apiVersion: DeveloperServicesAPIVersion { get }

    var methodOverride: String? { get }
    var action: String { get }
    var parameters: [String: Any] { get }

    func configure(urlRequest: inout HTTPRequest)

    func parse(_ response: Response) async throws -> Value
}

public extension DeveloperServicesRequest {
    var apiVersion: DeveloperServicesAPIVersion { DeveloperServicesAPIVersionLegacy() }
    var methodOverride: String? { nil }
    func configure(urlRequest: inout HTTPRequest) {}
}

public extension DeveloperServicesRequest where Response == Value {
    func parse(_ response: Response) -> Response {
        response
    }
}
