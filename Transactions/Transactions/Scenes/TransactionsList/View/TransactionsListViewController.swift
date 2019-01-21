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
    func displayUser(image: UIImage)
    func displayError(message: String)
    func displayTransactions(list: TransactionsListViewModel)
}

class TransactionsListViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak private var errorView: UIView!
    @IBOutlet weak private var headerView: UIView!
    @IBOutlet weak private var loadingView: UIView!
    @IBOutlet weak private var errorMessage: UILabel!
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var userImageView: UIImageView!
    @IBOutlet weak private var totalBalanceLabel: UILabel!
    @IBOutlet weak private var balancePeriodLabel: UILabel!

    //MARK: Properties
    private var nextpage = ""
    private var transactionData: [TransactionViewModel] = []
    private var interactor: TransactionListInteractor?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        self.interactor?.loadUserImage()
        self.interactor?.getTransactionsList()
    }
    
    private func setup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.registerTableViewCells()
        let presenter = TransactionListPresenter()
        let interactor = TransactionListInteractor(presenter: presenter)
        self.interactor = interactor
        presenter.viewController = self
        
        configView()
    }
    
    private func verifyIfHasNextPage() {
        let hasNext = !self.nextpage.isEmpty
        if hasNext {
            self.interactor?.getTransactionsList(page: self.nextpage)
        }
    }
    
    private func configView() {
        self.userImageView.setImageBorder(color: UIColor.white.cgColor, width: 2.0, radius: 30)
        self.headerView.setGradient(startColor: Colors.pink.cgColor, finalColor: Colors.blue.cgColor)
    }
    
    private func registerTableViewCells() {
        self.tableView.register(UINib(nibName: "BalanceItemCell", bundle: nil), forCellReuseIdentifier: "BalanceItemCell")
    }
    
    //MARK: Actions
    @IBAction func userProfilePressed(_ sender: Any) {
        TransactionAppRouter.routeToUserProfile()
    }
}

//MARK: TransactionsListDisplayLogic
extension TransactionsListViewController: TransactionsListDisplayLogic {
    
    func hideLoadingView() {
        self.loadingView.isHidden = true
    }
    
    func displayLoadingView() {
        self.loadingView.isHidden = false
    }
    
    func displayUser(image: UIImage) {
        self.userImageView.image = image
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

//MARK: UITableViewDelegate / UITableViewDataSource
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
