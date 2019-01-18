//
//  Transaction.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/17/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

struct Transaction: Decodable {
    var date: String
//    var effectiveDate: String
    var description: String
    var amount: String
    var coordinates: String
}
