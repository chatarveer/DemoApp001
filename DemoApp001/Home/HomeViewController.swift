//
//  HomeViewController.swift
//  DemoApp001
//
//  Created Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeViewProtocol {
    
    var presenter: HomePresenterProtocol?
    
    @IBOutlet weak var collectionViewDamageArea: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setup()
    }
    
    func showLoader() {
        ///
    }
    
    func hideLoader() {
        ///
    }
    
    func selectPickerType() {
        
        let alertController = UIAlertController(title: "", message: "Please select picker type.", preferredStyle: .actionSheet)
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            //Cancel Action is selected
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action:UIAlertAction) in
            self.presenter?.openImagePicker(sourceType: .camera)
        }
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { (action:UIAlertAction) in
            self.presenter?.openImagePicker(sourceType: .gallery)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(cameraAction)
        alertController.addAction(galleryAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func reloadCollection() {
        ///
    }    
}

extension HomeViewController: SetupViewController {
    func setup() {
        
        self.collectionViewDamageArea.delegate = self
        self.collectionViewDamageArea.dataSource = self
        
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        collectionViewDamageArea?.register(nib, forCellWithReuseIdentifier: "HomeCollectionViewCell")
    }
    
    func setupNavigation() {
        self.title = "eKar"
    }
    
    
}
