//
//  TransactionsAPIError.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/17/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

enum TransactionsAPIError: Error {
    case badRequest
    case notFound(String?)
    case unauthorized(String?)
    case unknownResponse
    case invalidJson
    case noInternet
    case erro500
    
    var errorMessage: String {
        switch self {
        case .noInternet:
            return Constants.lostConnectionMessage
        case .notFound(let genericResponse):
            guard let status = genericResponse else {
                return Constants.defaultServerFailureError
            }
            return status
        case .unauthorized(let genericResponse):
            guard let status = genericResponse else {
                return Constants.defaultServerFailureError
            }
            return status
        default:
            return Constants.defaultServerFailureError
        }
    }
}
