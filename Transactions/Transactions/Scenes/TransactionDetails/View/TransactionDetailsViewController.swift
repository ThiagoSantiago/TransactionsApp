//
//  TransactionDetailsViewController.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/17/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit
import MapKit

class TransactionDetailsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var headerContentView: UIView!
    @IBOutlet weak var infosContentView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableContentViewHeightConstraint: NSLayoutConstraint!
    
    var transaction: TransactionViewModel?
    var latitude: Double?
    var longitude: Double?
    var tableViewData: [(title: String, description: String)] = []
    let regionRadius: CLLocationDistance = 800000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        configViews()
        setTransactionInfos()
        registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        self.tableView.register(UINib(nibName: "DescriptionItemCell", bundle: nil), forCellReuseIdentifier: "DescriptionItemCell")
    }
    
    func configViews() {
        self.infosContentView.layer.cornerRadius = 8
        self.headerContentView.setGradient(startColor: Colors.pink.cgColor, finalColor: Colors.blue.cgColor)
        self.infosContentView.setShadow(color: UIColor.black.cgColor, opacity: 0.6, shadowRadius: 5.0)
    }
    
    func setTransactionInfos() {
        self.descriptionLabel.text = transaction?.description
        
        self.tableViewData.append((title: "Value:", description: transaction?.amount.formatCurrency() ?? ""))
        self.tableViewData.append((title: "Date:", description: transaction?.date.formatDateString() ?? ""))
        self.tableViewData.append((title: "Effective date:", description: transaction?.effectiveDate.formatDateString() ?? ""))
        self.tableContentViewHeightConstraint.constant = CGFloat((self.tableViewData.count * 80) + 80)
        
        setTransactionLocation()
        
        self.tableView.reloadData()
    }
    
    func setTransactionLocation() {
        self.latitude = transaction?.latitude
        self.longitude = transaction?.longitude
        
        setLocationOnTheMap()
    }
    
    func setLocationOnTheMap() {
        let cityLocation = CLLocation(latitude: self.latitude ?? 0.0, longitude: self.longitude ?? 0.0)
        centerMapOnLocation(location: cityLocation)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        self.mapView.setRegion(coordinateRegion, animated: true)
        addPinOnMap()
    }
    
    func addPinOnMap() {
        let annotation = MKPointAnnotation()
        let pointCoord = CLLocationCoordinate2D(latitude: self.latitude ?? 0.0, longitude: self.longitude ?? 0.0)
        annotation.coordinate = pointCoord
    
        self.mapView.addAnnotation(annotation)
    }
}

extension TransactionDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionItemCell", for: indexPath) as? DescriptionItemCell else {
            return UITableViewCell()
        }
        cell.setContent(title: tableViewData[indexPath.row].title, description: tableViewData[indexPath.row].description)
        
        return cell
    }
}

extension TransactionDetailsViewController {
    @IBAction func backButtonPressed(_ sender: Any) {
        TransactionAppRouter.popView()
    }
}
