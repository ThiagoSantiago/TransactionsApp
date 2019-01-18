//
//  TransactionList.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/17/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

struct TransactionList: Decodable {
    var transactions: [Transaction]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.transactions = try container.decode([Transaction].self)
    }
}
