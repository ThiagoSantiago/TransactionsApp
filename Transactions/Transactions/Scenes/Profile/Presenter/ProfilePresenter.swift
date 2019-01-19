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
    typealias UserViewModel = [(title: String, description: String)]
    
    func presentUserInfo(_ userInfo: UserInfo) {
        var viewModel = UserViewModel()
        
        viewModel.append((title: "Name", description: userInfo.name))
        viewModel.append((title: "Surname", description: userInfo.surname))
        viewModel.append((title: "Birthdate", description: userInfo.birthdate))
        viewModel.append((title: "Nationality", description: userInfo.nationality))
        viewModel.append((title: "Full name", description: "\(userInfo.name) \(userInfo.surname)"))
        
        viewController?.displayUser(info: viewModel)
    }
    
    func presentError(_ error: TransactionsAPIError) {
        viewController?.displayError(message: error.errorMessage)
    }
}

