//
//  TransactionListPresenterTests.swift
//  TransactionsTests
//
//  Created by Thiago Santiago on 1/20/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import XCTest
@testable import Transactions
class TransactionListPresenterTests: XCTestCase {
    var presenter: TransactionListPresenter!
    var worker: TransactionsWorkerMock!
    
    override func setUp() {
        presenter = TransactionListPresenter()
        worker = TransactionsWorkerMock()
    }

    func testShouldTreatTheTransactionDataWithSuccess() {
        let transactionList = TransactionList(transactions: worker.createTransactionsList(), nextPage: "")
        
        let transactionsViewModel = presenter.treatTransactionData(transactionList)
        
        XCTAssertNotNil(transactionsViewModel)
        XCTAssertNotNil(transactionsViewModel.totalBalance)
        XCTAssertEqual(transactionsViewModel.transactions.count, 55)
    }
}
