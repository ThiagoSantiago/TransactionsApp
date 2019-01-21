//
//  TransactionsAPIMock.swift
//  TransactionsTests
//
//  Created by Thiago Santiago on 1/20/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation
import Alamofire
@testable import Transactions

class TransactionsWorkerMock: TransactionsWorker {
    var isFailure = false
    
    override func getTransactions(page: String, success: @escaping GetTransactionsSuccess, failure: @escaping Failure) {
        TransactionsAPI.request( .getTransactionsList(page: page)) { (result: Result<TransactionList>, httpResponse)  in
            if self.isFailure {
                failure(TransactionsAPIError.unknownResponse)
            } else {
                let transactionList = TransactionList(transactions: self.createTransactionsList(), nextPage: "")
                
                success(transactionList)
            }
        }
    }
    
    func createTransactionsList() -> [Transaction] {
        var transactions: [Transaction] = []
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: "transactions", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                transactions = try decoder.decode([Transaction].self, from: data)
                
                return transactions
            } catch {
                return transactions
            }
        } else {
            return transactions
        }
    }
    
    override func getUserInfo(success: @escaping TransactionsWorker.GetUserSuccess, failure: @escaping TransactionsWorker.Failure) {
        if isFailure {
            failure(TransactionsAPIError.unknownResponse)
        } else {
            let user = UserInfo(name: "Ernesto", surname: "Skipper", birthdate: "15/08/1970", nationality: "AUS")
            success(user)
        }
    }
    
    override func loadImage(success: @escaping TransactionsWorkerMock.GetUserImageSuccess, failure: @escaping TransactionsWorkerMock.Failure) {}
    
    override func saveUser(image: UIImage, success: @escaping TransactionsWorkerMock.UserImageSavedSuccess, failure: @escaping TransactionsWorkerMock.Failure) {}
}
