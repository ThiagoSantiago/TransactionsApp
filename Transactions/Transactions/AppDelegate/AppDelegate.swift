//
//  AppDelegate.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/16/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let homeController = TransactionsListViewController()
        let navigationController = UINavigationController(rootViewController: homeController)
        navigationController.view.frame = self.window!.bounds
        navigationController.isNavigationBarHidden = true
        
        TransactionAppRouter.setupRouter(navigationController: navigationController)
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

