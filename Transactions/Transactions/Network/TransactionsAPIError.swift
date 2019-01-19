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
    case notFound
    case unauthorized
    case unknownResponse
    case invalidJson
    case noInternet
    case erro500
    
    var errorMessage: String {
        switch self {

        default:
            return Constants.defaultServerFailureError
        }
    }
}
