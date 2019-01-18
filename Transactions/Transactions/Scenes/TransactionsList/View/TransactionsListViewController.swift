//
//  TransactionsListViewController.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/16/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

protocol TransactionsListDisplayLogic: class {
    func displayError(message: String)
    func displayTransactions(list: [Transaction])
}

class TransactionsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImageView: UIImageView!
    
    var transactionData: [Transaction] = []
    var interactor: TransactionListInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        configView()
        self.interactor?.getTransactionsList()
    }
    
    fileprivate func setup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.registerTableViewCells()
        
        let interactor = TransactionListInteractor()
        self.interactor = interactor
        let presenter = TransactionListPresenter()
        presenter.viewController = self
        interactor.presenter = presenter
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

extension TransactionsListViewController: TransactionsListDisplayLogic {
    func displayError(message: String) {
        print("Error message: \(message)")
    }
    
    func displayTransactions(list: [Transaction]) {
        self.transactionData = list
        self.tableView.reloadData()
    }
}

extension TransactionsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceItemCell", for: indexPath) as? BalanceItemCell else { return UITableViewCell()}
        
        let transaction = transactionData[indexPath.row]
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        cell.transactionNameLabel.text = transaction.description
        cell.transactionDateLabel.text = transaction.date
        cell.transactionValueLabel.text = transaction.amount
        
        return cell
    }
}
