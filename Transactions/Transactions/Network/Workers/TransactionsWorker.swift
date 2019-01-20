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
    func getTransactions(page: String, success: @escaping GetTransactionsSuccess, failure: @escaping Failure) {
        TransactionsAPI.request( .getTransactionsList(page: page)) { (result: Result<TransactionList>, httpResponse)  in
            switch result {
            case .success(let transactions):
                var transactionList = transactions
                if let nextPage = httpResponse.response?.allHeaderFields["next-page"] as? String {
                    let substringArray = nextPage.split(separator: "/")
                    
                    if let lastString = substringArray.last {
                        transactionList.nextPage = "\(lastString)"
                    }
                }
                
                success(transactionList)
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
        TransactionsAPI.request(.getUserInfos()) { (result: Result<UserInfo>, httpResponse) in
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
 
    typealias GetUserImageSuccess = (_ userImage: UIImage) -> Void
    func loadImage(success: @escaping GetUserImageSuccess, failure: @escaping Failure) {
        if let imageString = UserDefaults.standard.string(forKey: Constants.userImageKey),
            let imageData = Data(base64Encoded: imageString, options: .ignoreUnknownCharacters) {
            
            guard let imageDecoded = UIImage(data: imageData) else {
                failure(TransactionsAPIError.unknownResponse)
                return
            }
            
            success(imageDecoded)
        } else {
            failure(TransactionsAPIError.unknownResponse)
        }
    }
    
    typealias UserImageSavedSuccess = (_ saved: Bool) -> Void
    func saveUser(image: UIImage, success: @escaping UserImageSavedSuccess, failure: @escaping Failure) {
        if let base64Image = image.pngData()?.base64EncodedString(options: .lineLength64Characters) {
            UserDefaults.standard.set(base64Image, forKey: Constants.userImageKey)
            success(true)
        } else {
            failure(TransactionsAPIError.unknownResponse)
        }
    }
}
