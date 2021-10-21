//
//  ErrorResponse.swift
//  MoviesGuide
//
//  Created by Irshad Qureshi on 16/10/2021.
//

import Foundation

public struct ErrorResponse: Codable {
    public let code: Int
    public let info: String
}

