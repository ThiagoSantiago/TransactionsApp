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
    @IBOutlet weak var infosContentView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var effectiveLabel: UILabel!
    
    var transaction: TransactionViewModel?
    var latitude: Double?
    var longitude: Double?
    let regionRadius: CLLocationDistance = 800000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViews()
        setTransactionInfos()
    }
    
    func configViews() {
        self.infosContentView.layer.cornerRadius = 8
        self.infosContentView.setShadow(color: UIColor.black.cgColor, opacity: 0.6, shadowRadius: 5.0)
    }
    
    func setTransactionInfos() {
        self.descriptionLabel.text = transaction?.description
        self.amountLabel.text = "Value: \(transaction?.amount)"
        self.dateLabel.text = "Date: \(transaction?.date)"
        
        setTransactionLocation()
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
        mapView.setRegion(coordinateRegion, animated: true)
        addPinOnMap()
    }
    
    func addPinOnMap() {
        let annotation = MKPointAnnotation()
        let pointCoord = CLLocationCoordinate2D(latitude: self.latitude ?? 0.0, longitude: self.longitude ?? 0.0)
        annotation.coordinate = pointCoord
    
        mapView.addAnnotation(annotation)
    }
}

extension TransactionDetailsViewController {
    @IBAction func backButtonPressed(_ sender: Any) {
        TransactionAppRouter.popView()
    }
}
