//
//  TransactionAppRouter.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/17/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

protocol TransactionsAppRoutingProtocol {
    static func popView()
    static func routeToUserProfile()
    static func routeToDetails(transaction: Transaction)
}

class TransactionAppRouter: TransactionsAppRoutingProtocol {
    var navigationController: UINavigationController?
    
    private static var sharedRouter: TransactionAppRouter = {
        let router = TransactionAppRouter()
        return router
    }()
    
    public static func setupRouter(navigationController: UINavigationController) {
        self.shared().navigationController = navigationController
    }
    
    class func shared() -> TransactionAppRouter {
        return sharedRouter
    }
    
    static func popView() {
        if let navigationController = self.sharedRouter.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    static func routeToUserProfile() {
        let viewController = ProfileViewController()
        
        if let navigationController = self.sharedRouter.navigationController {
            navigationController.pushViewController(viewController, animated: true)
        } else {
            print("Present error trying to access the view controller.")
        }
    }
    
    public static func routeToDetails(transaction: Transaction) {
        let viewController = TransactionDetailsViewController()
        viewController.transaction = transaction
        
        if let navigationController = self.sharedRouter.navigationController {
            navigationController.pushViewController(viewController, animated: true)
        } else {
            print("Present error trying to access the view controller.")
        }
    }
}
