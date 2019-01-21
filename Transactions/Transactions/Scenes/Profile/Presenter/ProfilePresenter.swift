//
//  ProfilePresenter.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/18/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

protocol ProfilePresentationLogic {
    func closeLoadingView()
    func presenterLoadignView()
    func presentUser(_ image: UIImage)
    func presentUserInfo(_ userInfo: UserInfo)
    func presentError(_ error: TransactionsAPIError)
}

class ProfilePresenter: ProfilePresentationLogic {
    
    weak var viewController: ProfileDisplayLogic?
    typealias UserViewModel = [(title: String, description: String)]
    
    func closeLoadingView() {
        viewController?.hideLoading()
    }
    
    func presenterLoadignView() {
        viewController?.displayLoadingView()
    }
    
    func presentUser(_ image: UIImage) {
        viewController?.displayUser(image: image)
    }
    
    func presentUserInfo(_ userInfo: UserInfo) {
        viewController?.displayUser(info: treatUserInfos(user: userInfo))
    }
    
    func treatUserInfos(user: UserInfo) -> UserViewModel {
        var viewModel = UserViewModel()
        
        viewModel.append((title: "Name", description: user.name))
        viewModel.append((title: "Surname", description: user.surname))
        viewModel.append((title: "Birthdate", description: user.birthdate))
        viewModel.append((title: "Nationality", description: user.nationality))
        viewModel.append((title: "Full name", description: "\(user.name) \(user.surname)"))
        
        return viewModel
    }
    
    func presentError(_ error: TransactionsAPIError) {
        viewController?.displayError(message: error.errorMessage)
    }
}

