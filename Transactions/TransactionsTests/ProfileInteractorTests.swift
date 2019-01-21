//
//  ProfileInteractorTests.swift
//  TransactionsTests
//
//  Created by Thiago Santiago on 1/21/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import XCTest
@testable import Transactions

class ProfileInteractorTests: XCTestCase {
    var worker: TransactionsWorkerMock!
    var interactor: ProfileInteractor!
    var presenter: ProfilePresenterMock!
    
    override func setUp() {
        worker = TransactionsWorkerMock()
        presenter = ProfilePresenterMock()
        interactor = ProfileInteractor(presenter: presenter, worker: worker)
    }

    func testShouldPresentUserInfoWhenWorkerRetrunsSuccess() {
        worker.isFailure = false
        interactor.getUserInfos()
        
        XCTAssertTrue(presenter.loadingPresented)
        XCTAssertTrue(presenter.userInfosPresented)
        XCTAssertTrue(presenter.closeLoadingPresented)
        XCTAssertFalse(presenter.errorWasPresented)
    }
    
    func testShouldPresentUserInfoErrorWhenWorkerRetrunsError() {
        worker.isFailure = true
        interactor.getUserInfos()
        
        XCTAssertTrue(presenter.loadingPresented)
        XCTAssertFalse(presenter.userInfosPresented)
        XCTAssertTrue(presenter.closeLoadingPresented)
        XCTAssertTrue(presenter.errorWasPresented)
    }
    
    func testShouldPresentUserImageWhenWorkerRetrunsSuccess() {
        interactor.loadUserImage()
        
        XCTAssertTrue(presenter.userImagePresented)
    }
    
    func testShouldInformeIfTheUserImageWasSavedWhenWorkerRetrunsSuccess() {
        let userSaved = interactor.saveUser(image: UIImage(named: "ic_wallet")!)
        
        XCTAssertTrue(userSaved)
    }
    
    func testShouldInformeIfTheUserImageWasNotSavedWhenWorkerRetrunsError() {
        worker.isFailure = true
        let userSaved = interactor.saveUser(image: UIImage(named: "ic_wallet")!)
        
        XCTAssertFalse(userSaved)
    }
}
