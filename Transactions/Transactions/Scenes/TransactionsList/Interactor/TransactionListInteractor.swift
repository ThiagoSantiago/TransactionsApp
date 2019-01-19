//
//  TransactionListInteractor.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/17/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

protocol TransactionListBusinessLogic {
    func getTransactionsList(page: String)
}

class TransactionListInteractor: TransactionListBusinessLogic {
    var presenter: TransactionListPresentationLogic?
    var worker = TransactionsWorker()
    
    func getTransactionsList(page: String = "transactions") {
        presenter?.presentLoadingView()
        worker.getTransactions(page: page, success: { transactionList in
            self.presenter?.presentList(transactionList)
            self.presenter?.closeLoadingView()
        }) { error in
            self.presenter?.presentError(error)
            self.presenter?.closeLoadingView()
        }
    }
}
