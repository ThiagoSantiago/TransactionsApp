//
//  TransactionsListViewController.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/16/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

class TransactionsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        configView()
    }
    
    fileprivate func setup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.registerTableViewCells()
    }
    
    fileprivate func configView() {
        self.userImageView.layer.borderColor = UIColor.white.cgColor
        self.userImageView.layer.borderWidth = 2.0
        self.userImageView.layer.cornerRadius = 30
    }
    
    fileprivate func registerTableViewCells() {
        self.tableView.register(UINib(nibName: "BalanceItemCell", bundle: nil), forCellReuseIdentifier: "BalanceItemCell")
    }
}

extension TransactionsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceItemCell", for: indexPath)
        
        return cell
    }
}
