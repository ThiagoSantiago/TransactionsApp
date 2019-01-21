//
//  TransactionListPresenterMock.swift
//  TransactionsTests
//
//  Created by Thiago Santiago on 1/20/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit
@testable import Transactions

class TransactionListPresenterMock: TransactionListPresenter {
    var loadingPresented: Bool = false
    var errorWasPresented: Bool = false
    var userInfosPresented: Bool = false
    var closeLoadingPresented: Bool = false
    var trasactionsListPresented: Bool = false
    
    override func closeLoadingView() {
        closeLoadingPresented = true
    }
    
    override func presentLoadingView() {
        loadingPresented = true
    }
    
    override func presentUser(_ image: UIImage) {
        userInfosPresented = true
    }
    
    override func presentList(_ transactions: TransactionList) {
        trasactionsListPresented = true
    }
    
    override func presentError(_ error: TransactionsAPIError) {
        errorWasPresented = true
    }
}
