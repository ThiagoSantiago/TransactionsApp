//
//  ProfileInteractor.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/18/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

protocol ProfileBusinessLogic {
    func getUserInfos()
}

class ProfileInteractor: ProfileBusinessLogic {
    var presenter: ProfilePresentationLogic?
    var worker = TransactionsWorker()
    
    init(presenter: ProfilePresentationLogic?,
         worker: TransactionsWorker = TransactionsWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
    
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
    
    func loadUserImage() {
        worker.loadImage(success: { image in
            self.presenter?.presentUser(image)
        }) { _ in }
    }
    
    @discardableResult
    func saveUser(image: UIImage) -> Bool {
        var wasSaved = false
        worker.saveUser(image: image, success: { _ in
            wasSaved = true
        }) { _ in
            wasSaved = false
        }
        return wasSaved
    }
}
