//
//  TransactionsWorker.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/16/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation
import Alamofire

class TransactionsWorker {
    typealias Failure = (_ error: TransactionsAPIError) -> Void
    
    typealias GetTransactionsSuccess = (_ transactions: TransactionList) -> Void
    func getTransactions(success: @escaping GetTransactionsSuccess, failure: @escaping Failure) {
        TransactionsAPI.request( .getTransactionsList()) { (result: Result<TransactionList>) in
            switch result {
            case .success(let transactions):
                success(transactions)
            case .failure(let error):
                guard let apiError = error as? TransactionsAPIError else {
                    failure(TransactionsAPIError.unknownResponse)
                    return
                }
                
                failure(apiError)
            }
        }
    }
    
    typealias GetUserSuccess = (_ userInfo: UserInfo) -> Void
    func getUserInfo(success: @escaping GetUserSuccess, failure: @escaping Failure) {
        TransactionsAPI.request(.getUserInfos()) { (result: Result<UserInfo>) in
            switch result {
            case .success(let user):
                success(user)
            case .failure(let error):
                guard let apiError = error as? TransactionsAPIError else {
                    failure(TransactionsAPIError.unknownResponse)
                    return
                }
                
                failure(apiError)
            }
        }
    }
}
