//
//  ProfileInteractor.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/18/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

protocol ProfileBusinessLogic {
    func getUserInfos()
}

class ProfileInteractor: ProfileBusinessLogic {
    var presenter: ProfilePresentationLogic?
    var worker = TransactionsWorker()
    
    func getUserInfos() {
        self.presenter?.presenterLoadignView()
        worker.getUserInfo(success: { userInfo in
            self.presenter?.closeLoadingView()
            self.presenter?.presentUserInfo(userInfo)
        }) { error in
            self.presenter?.closeLoadingView()
            self.presenter?.presentError(error)
        }
    }
}
