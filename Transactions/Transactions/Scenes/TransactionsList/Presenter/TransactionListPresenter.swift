//
//  TransactionsListPresenter.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/17/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

protocol TransactionListPresentationLogic {
    func presentList(_ transactions: [Transaction])
    func presentError(_ error: TransactionsAPIError)
}

class TransactionListPresenter: TransactionListPresentationLogic {
    weak var viewController: TransactionsListDisplayLogic?
    
    func presentList(_ transactions: [Transaction]) {
        viewController?.displayTransactions(list: transactions)
    }
    
    func presentError(_ error: TransactionsAPIError) {
        viewController?.displayError(message: error.errorMessage)
    }
}
