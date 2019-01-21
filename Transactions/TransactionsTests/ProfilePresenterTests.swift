//
//  ProfilePresenterTests.swift
//  TransactionsTests
//
//  Created by Thiago Santiago on 1/20/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import XCTest
@testable import Transactions

class ProfilePresenterTests: XCTestCase {
    var presenter: ProfilePresenter!
    var user: UserInfo!
    override func setUp() {
        presenter = ProfilePresenter()
        user = UserInfo(name: "Ernesto", surname: "Skipper", birthdate: "15/08/1970", nationality: "AUS")
    }
    
    func testShouldTreatTheUserInfosWithSuccess() {
        let userViewModel = presenter.treatUserInfos(user: user)
        
        XCTAssertNotNil(userViewModel)
        XCTAssertEqual(userViewModel[0].description, "Ernesto")
        XCTAssertEqual(userViewModel[1].description, "Skipper")
        XCTAssertEqual(userViewModel[2].description, "15/08/1970")
        XCTAssertEqual(userViewModel[3].description, "AUS")
        XCTAssertEqual(userViewModel[4].description, "Ernesto Skipper")
    }
}
