//
//  ReportViewController.swift
//  DemoApp001
//
//  Created Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import UIKit

class ReportViewController: BaseViewController, ReportViewProtocol {
    
    var presenter: ReportPresenterProtocol?
    
    @IBOutlet weak var collectionViewDamageArea: UICollectionView!
    @IBOutlet weak var textViewComments: PlaceholderTextView!
    @IBOutlet weak var button_next: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setup()
        networkRequests()
    }
    
    @IBAction func didPressSubmit(_ sender: UIButton) {
        textViewComments.endEditing(true)
        self.presenter?.submit()
    }
    
    func showLoader() {
        ///
    }
    
    func hideLoader() {
        ///
    }
    
    func selectPickerType() {
        
        let alertController = UIAlertController(title: "", message: "Please select picker type.", preferredStyle: .alert)
        
        
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
        DispatchQueue.main.async {
            self.collectionViewDamageArea.reloadData()
        }
    }
    
    func reloadCollection(indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.collectionViewDamageArea.reloadItems(at: [indexPath])
        }
    }
    
    func updateCommentViewToDefaultState() {
        DispatchQueue.main.async {
            self.textViewComments.backgroundColor = .white
        }
    }
    
    func commentInvalid() {
        DispatchQueue.main.async {
            self.textViewComments.shake()
        }
    }
    
    func imageInvalid(indexPath: IndexPath) {
        if let cell = collectionViewDamageArea.cellForItem(at: indexPath) as? ReportCollectionViewCell {
            cell.errorUI()
        }
    }
}

extension ReportViewController: SetupViewController {
    func setup() {
        
        self.collectionViewDamageArea.delegate = self
        self.collectionViewDamageArea.dataSource = self
        
        let nib = UINib(nibName: "ReportCollectionViewCell", bundle: nil)
        collectionViewDamageArea?.register(nib, forCellWithReuseIdentifier: "ReportCollectionViewCell")
        
        self.textViewComments.delegate = self
        button_next.setBorderColor(.gray)
        button_next.setBorderWidth(1.0)
        
        self.textViewComments.roundCorners(4.0)
        self.textViewComments.border(width: 1.0, color: .gray)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ReportViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReportViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.textViewComments.backgroundColor = .white
    }
    
    func setupNavigation() {
        self.title = "DemoApp001"
    }
    
    func networkRequests() {
        self.presenter?.getDamagedImages()
    }
}

extension ReportViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        self.presenter?.set(comment: text)
    }
}

extension ReportViewController {
    @objc func keyboardWillShow(notification:NSNotification) {
        adjustView(show: true, notification: notification)
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        adjustView(show: false, notification: notification)
    }
    
    func adjustView(show:Bool, notification:NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let animationDurarion = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        let changeInHeight = (keyboardFrame.size.height + 40/*or any value as per need*/) * (show ? 1 : -1)
        UIView.animate(withDuration: animationDurarion, animations: { () -> Void in
            // change height Constraint or change height with changeInHeight here to your UItextView/other view
            if show {
                self.view.frame.origin.y = -changeInHeight
            }else {
                self.view.frame.origin.y = 0
            }
        })
        
    }
}
