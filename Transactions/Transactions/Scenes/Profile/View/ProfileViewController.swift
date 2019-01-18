//
//  ProfileViewController.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/18/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

protocol ProfileDisplayLogic: class {
    func displayError(message: String)
    func displayUser(info: UserInfo)
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    var interactor: ProfileInteractor?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        interactor?.getUserInfos()
    }
    
    func setup() {
        let interactor = ProfileInteractor()
        self.interactor = interactor
        let presenter = ProfilePresenter()
        presenter.viewController = self
        interactor.presenter = presenter
    }

}


extension ProfileViewController: ProfileDisplayLogic {
    func displayError(message: String) {
        print("Show error")
    }
    
    func displayUser(info: UserInfo) {
        self.userNameLabel.text = "\(info.name) \(info.surname)"
    }
        
}
