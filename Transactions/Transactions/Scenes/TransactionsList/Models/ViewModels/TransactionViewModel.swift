//
//  TransactionsViewModel.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/18/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

enum TransactionType {
    case credit
    case debit
}

struct TransactionViewModel {
    var date: String
    var amount: String
    var description: String
    var latitude: Double
    var longitude: Double
    var effectiveDate: String
    var transactionType: TransactionType
}
