//
//  ProfileViewController.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/18/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

protocol ProfileDisplayLogic: class {
    typealias UserViewModel = [(title: String, description: String)]
    
    func displayError(message: String)
    func displayUser(info: UserViewModel)
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var userImageView: UIImageView!
    @IBOutlet weak private var infoContentView: UIView!
    @IBOutlet weak private var changePhotoButton: UIButton!
    @IBOutlet weak private var tableView: UITableView!
    
    private var interactor: ProfileInteractor?
    private let imagePicker = UIImagePickerController()
    fileprivate var tableViewData: UserViewModel = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        interactor?.getUserInfos()
    }
    
    private func setup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let interactor = ProfileInteractor()
        self.interactor = interactor
        let presenter = ProfilePresenter()
        presenter.viewController = self
        interactor.presenter = presenter
        
        self.registerTableViewCells()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        configViews()
    }
    
    private func registerTableViewCells() {
        self.tableView.register(UINib(nibName: "DescriptionItemCell", bundle: nil), forCellReuseIdentifier: "DescriptionItemCell")
    }
    
    func configViews() {
        self.infoContentView.layer.cornerRadius = 8
        self.changePhotoButton.layer.cornerRadius = 25
        self.userImageView.setImageBorder(color: UIColor.white.cgColor, width: 2.0, radius: 40)
        self.infoContentView.setShadow(color: UIColor.black.cgColor, opacity: 0.6, shadowRadius: 5.0)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        TransactionAppRouter.popView()
    }
    
    @IBAction func changePhotoPressed(_ sender: Any) {
        let optionMenu = UIAlertController(title:"Take a picture", message: "Choose an image from your galery or take a new one.", preferredStyle: .actionSheet)
        
        let chooseAPicture = UIAlertAction(title: "Choose a picture", style: .default, handler: { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        
        let takeANewPicture = UIAlertAction(title: "Take a picture", style: .default) { _ in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil) }
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        
        optionMenu.addAction(chooseAPicture)
        optionMenu.addAction(takeANewPicture)
        optionMenu.addAction(cancel)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
}

extension ProfileViewController: ProfileDisplayLogic {
    func displayError(message: String) {
        print("Show error")
    }
    
    func displayUser(info: UserViewModel) {
        self.tableViewData = info
        self.userNameLabel.text = info[4].description
        self.tableView.reloadData()
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
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

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        self.userImageView.image = selectedImage
    }
}
