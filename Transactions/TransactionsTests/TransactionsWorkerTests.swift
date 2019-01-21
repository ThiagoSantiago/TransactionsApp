//
//  TransactionsTests.swift
//  TransactionsTests
//
//  Created by Thiago Santiago on 1/16/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import XCTest
@testable import Transactions

class TransactionsWorkerTests: XCTestCase {
    var worker: TransactionsWorkerMock!
    
    override func setUp() {
        super.setUp()
        self.worker = TransactionsWorkerMock()
    }

    func testShouldGetTheListOfTransactionsWithSuccess() {
        self.worker.isFailure = false
        self.worker.getTransactions(page: "transactions", success: { result in
            
            let transaction = Transaction(date: "8-01-18 14:18", amount: "-86,21", description: "Transaction 1", coordinates: "4.8432112, 52.3872824", effectiveDate: "9-01-18 14:18")
            let firstTransaction = result.transactions.first
            
            XCTAssertNotNil(result)
            XCTAssertFalse(result.transactions.isEmpty)
            XCTAssertEqual(transaction, firstTransaction)
        }) { _ in
            XCTFail("Could not return Transactions.")
        }
    }
    
    func testShouldGetTheListOfTransactionsWithError() {
        self.worker.isFailure = true
        self.worker.getTransactions(page: "transactions", success: { _ in
            XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = "Oops! Looks like something get wrong, I'm really sorry. Could you try again?"
            
            XCTAssertNotNil(error)
            XCTAssertEqual(errorMessage, error.errorMessage)
            XCTAssertEqual(error, TransactionsAPIError.unknownResponse)
        }
    }
    
    func testShouldGetUserInfoWithSuccess() {
        self.worker.isFailure = false
        self.worker.getUserInfo(success: { user in
            let userInfos = UserInfo(name: "Ernesto", surname: "Skipper", birthdate: "15/08/1970", nationality: "AUS")
            XCTAssertNotNil(user)
            XCTAssertEqual(user, userInfos)
        }) { _ in
            XCTFail("Could not return user infos.")
        }
    }
    
    func testShouldGetUserInfoWithError() {
        self.worker.isFailure = true
        self.worker.getUserInfo(success: { _ in
            XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = "Oops! Looks like something get wrong, I'm really sorry. Could you try again?"
            
            XCTAssertNotNil(error)
            XCTAssertEqual(errorMessage, error.errorMessage)
            XCTAssertEqual(error, TransactionsAPIError.unknownResponse)
        }
    }
    
    func testShouldSaveUserImageWithSuccess() {
        let worker = TransactionsWorker()
        guard let testImage = UIImage(named: "ic_wallet") else {
            XCTFail("Could not save the user image.")
            return
        }
        
        worker.saveUser(image: testImage, success: { result in
            XCTAssertTrue(result)
        }) { _ in
            XCTFail("Could not save the user image.")
        }
        
        UserDefaults.standard.removeObject(forKey: Constants.userImageKey)
    }
    
    func testShouldLoadUserImageWithSuccess() {
        let worker = TransactionsWorker()
        guard  let base64Image = UIImage(named: "ic_wallet")?.pngData()?.base64EncodedString(options: .lineLength64Characters) else {
            XCTFail("Could not load the user image.")
            return
        }
        
        UserDefaults.standard.set(base64Image, forKey: Constants.userImageKey)
        worker.loadImage(success: { image in
            XCTAssertNotNil(image)
        }) { _ in
            XCTFail("Could not load the user image.")
        }
        
        UserDefaults.standard.removeObject(forKey: Constants.userImageKey)
    }
    
}
