//
//  ProfilePresenter.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/18/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

protocol ProfilePresentationLogic {
    func presentUserInfo(_ userInfo: UserInfo)
    func presentError(_ error: TransactionsAPIError)
}

class ProfilePresenter: ProfilePresentationLogic {
    weak var viewController: ProfileDisplayLogic?
    
    func presentUserInfo(_ userInfo: UserInfo) {
        viewController?.displayUser(info: userInfo)
    }
    
    func presentError(_ error: TransactionsAPIError) {
        viewController?.displayError(message: error.errorMessage)
    }
}

