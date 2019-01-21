//
//  TransactionListInteractorTests.swift
//  TransactionsTests
//
//  Created by Thiago Santiago on 1/21/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import XCTest
@testable import Transactions

class TransactionListInteractorTests: XCTestCase {
    var worker: TransactionsWorkerMock!
    var interactor: TransactionListInteractor!
    var presenter: TransactionListPresenterMock!
    
    override func setUp() {
        super.setUp()
        
        worker = TransactionsWorkerMock()
        presenter = TransactionListPresenterMock()
        interactor = TransactionListInteractor(presenter: presenter, worker: worker)
    }

    func testShouldPresentListTransactionsWhenWorkerRetrunsSuccess() {
        worker.isFailure = false
        interactor.getTransactionsList()
        
        XCTAssertTrue(presenter.loadingPresented)
        XCTAssertTrue(presenter.trasactionsListPresented)
        XCTAssertTrue(presenter.closeLoadingPresented)
        XCTAssertFalse(presenter.errorWasPresented)
    }
    
    func testShouldPresentErrorWhenWorkerRetrunsError() {
        worker.isFailure = true
        interactor.getTransactionsList()
        
        XCTAssertTrue(presenter.loadingPresented)
        XCTAssertFalse(presenter.trasactionsListPresented)
        XCTAssertTrue(presenter.closeLoadingPresented)
        XCTAssertTrue(presenter.errorWasPresented)
    }
    
    func testShouldPresentUserImageWhenWorkerRetrunsSuccess() {
        interactor.loadUserImage()
        
        XCTAssertTrue(presenter.userInfosPresented)
    }
}
