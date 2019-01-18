//
//  TransactionListInteractor.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/17/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

protocol TransactionListBusinessLogic {
    func getTransactionsList()
}

class TransactionListInteractor: TransactionListBusinessLogic {
    var presenter: TransactionListPresentationLogic?
    var worker = TransactionsWorker()
    
    func getTransactionsList() {
        worker.getTransactions(success: { transactionList in
            self.presenter?.presentList(transactionList.transactions)
        }) { error in
            self.presenter?.presentError(error)
        }
    }
}
