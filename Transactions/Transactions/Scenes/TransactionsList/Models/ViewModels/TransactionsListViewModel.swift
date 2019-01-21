//
//  TransactionsListViewModel.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/18/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

struct TransactionsListViewModel {
    var transactions: [TransactionViewModel] = []
    var nextPage: String
    var totalBalance: String
}
