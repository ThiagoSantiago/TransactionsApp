//
//  TransactionsListViewController.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/16/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

protocol TransactionsListDisplayLogic: class {
    func hideLoadingView()
    func displayLoadingView()
    func displayError(message: String)
    func displayTransactions(list: TransactionsListViewModel)
}

class TransactionsListViewController: UIViewController {
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var totalBalanceLabel: UILabel!
    @IBOutlet weak var balancePeriodLabel: UILabel!

    var nextpage = ""
    var transactionData: [TransactionViewModel] = []
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
    
    func verifyIfHasNextPage() {
        let hasNext = !self.nextpage.isEmpty
        if hasNext {
            self.interactor?.getTransactionsList(page: self.nextpage)
        }
    }
    
    private func configView() {
        self.userImageView.setImageBorder(color: UIColor.white.cgColor, width: 2.0, radius: 30)
        self.headerView.setGradient(startColor: Colors.pink.cgColor, finalColor: Colors.blue.cgColor)
    }
    
    fileprivate func registerTableViewCells() {
        self.tableView.register(UINib(nibName: "BalanceItemCell", bundle: nil), forCellReuseIdentifier: "BalanceItemCell")
    }
}

extension TransactionsListViewController: TransactionsListDisplayLogic {
    func hideLoadingView() {
        self.loadingView.isHidden = true
    }
    
    func displayLoadingView() {
        self.loadingView.isHidden = false
    }
    
    func displayError(message: String) {
        self.errorView.isHidden = false
        self.errorMessage.text = message
    }
    
    func displayTransactions(list: TransactionsListViewModel) {
        self.errorView.isHidden = true
        self.nextpage = list.nextPage
        self.transactionData.append(contentsOf: list.transactions)
        self.totalBalanceLabel.text = list.totalBalance
        
        if let firstDate = list.transactions.first?.date,
           let lastDate = list.transactions.last?.date {
            self.balancePeriodLabel.text = "Balance of the period:\n \(firstDate) - \(lastDate)"
        } else {
            self.balancePeriodLabel.text = "Balance of the period"
        }
        
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
        cell.setContent(transaction: transaction)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TransactionAppRouter.routeToDetails(transaction: transactionData[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.transactionData.count - 1 {
            self.verifyIfHasNextPage()
        }
    }
}

extension TransactionsListViewController {
    @IBAction func userProfilePressed(_ sender: Any) {
        TransactionAppRouter.routeToUserProfile()
    }
}
