//
//  ErrorResponse.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/28/22.
//

import Foundation

// MARK: - ErrorResponse
public struct ErrorResponse: Codable {
    let stat: String
    let code: Int
    let message: String
}
