//
//  Transaction.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/17/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

struct Transaction {
    var date: String
    var amount: String
    var description: String
    var coordinates: String
    var effectiveDate: String
    
    enum CodingKeys: String, CodingKey {
        case date
        case amount
        case description
        case coordinates
        case effectiveDate = "effective date"
        
    }
}

extension Transaction: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        date = try values.decode(String.self, forKey: .date)
        amount = try values.decode(String.self, forKey: .amount)
        description = try values.decode(String.self, forKey: .description)
        coordinates = try values.decode(String.self, forKey: .coordinates)
        effectiveDate = try values.decode(String.self, forKey: .effectiveDate)
    }
}
