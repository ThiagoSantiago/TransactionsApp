//
//  ProfilePresenterMock.swift
//  TransactionsTests
//
//  Created by Thiago Santiago on 1/21/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit
@testable import Transactions

class ProfilePresenterMock: ProfilePresenter {
    var loadingPresented: Bool = false
    var errorWasPresented: Bool = false
    var userImagePresented: Bool = false
    var userInfosPresented: Bool = false
    var closeLoadingPresented: Bool = false
    
    
    override func closeLoadingView() {
        closeLoadingPresented = true
    }
    
    override func presenterLoadignView() {
        loadingPresented = true
    }
    
    override func presentUser(_ image: UIImage){
        userImagePresented = true
    }
    
    override func presentUserInfo(_ userInfo: UserInfo){
        userInfosPresented = true
    }
    
    override func presentError(_ error: TransactionsAPIError){
        errorWasPresented = true
    }
}
