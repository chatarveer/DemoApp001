//
//  ReportPresenter.swift
//  DemoApp001
//
//  Created Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import UIKit

class ReportPresenter: ReportPresenterProtocol, ReportInteractorOutputProtocol {
    
    weak private var view: ReportViewProtocol?
    var interactor: ReportInteractorInputProtocol?
    private let router: ReportWireframeProtocol
    
    var arrayDamagedImages: [DamagedImage]?
    var indexPath: IndexPath?
    var comment: String?
    
    let placeholder = UIImage(named: "placeholder")
    
    init(interface: ReportViewProtocol, interactor: ReportInteractorInputProtocol?, router: ReportWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func selectedIndex(indexPath: IndexPath) {
        self.indexPath = indexPath
        guard let arrayDamagedImages = self.arrayDamagedImages else { return }
        let image = arrayDamagedImages[indexPath.row]
        if image.image == placeholder {
            self.view?.selectPickerType(shouldShowDelete: false, for: indexPath)
        }else {
            self.view?.selectPickerType(shouldShowDelete: true, for: indexPath)
        }
    }
    
    func openImagePicker(sourceType: ImagePickerType) {
        ImagePickerManager.shared.openImagePicker(sourceType: sourceType, delegate: self)
    }
    
    func damagedImages(arrayDamagedImages: [DamagedImage]) {
        self.arrayDamagedImages = arrayDamagedImages
        self.view?.reloadCollection()
    }
    
    func getDamagedImages() {
        self.interactor?.getDamagedImages()
    }
    
    func submit() {
        //Validate all fields here
        guard let arrayDamagedImages = arrayDamagedImages else { return }
        
        var allImagesValid = true
        for (index, value) in arrayDamagedImages.enumerated() {
            let result = self.validate(image: value)
            let indexPath = IndexPath.init(row: index, section: 0)
            if !result.isValid {
                self.view?.imageInvalid(indexPath: indexPath)
                allImagesValid = false
            }
        }
        
        let isCommentValid = self.validate(comment: self.comment)
        
        if !isCommentValid {
            self.view?.commentInvalid()
        }
        
        if allImagesValid && isCommentValid {
            guard let arrayDamagedImages = self.arrayDamagedImages,
                let comment = self.comment else {
                    //Something went wrong alert
                    return
            }
            
            let complain = DamagedComplainRequest(comment: comment, damagedImages: arrayDamagedImages)
            self.interactor?.submit(damagedComplain: complain)
            
            //.submit(damagedImages: complain)
        }
    }
    
    func validate(comment: String?) -> Bool {
        guard let comment = comment else { return false }
        let result = comment.count > 0 ? true : false
        return result
    }
    
    func validate(image: DamagedImage) -> (image: DamagedImage, isValid: Bool) {
        guard (image.image) != placeholder else {
            return (image, false)
        }
        return (image, true)
    }
    
    func set(comment: String) {
        self.comment = comment.trim()
        self.view?.updateCommentViewToDefaultState()
    }
    
    func removeImage(indexPath: IndexPath) {
        self.arrayDamagedImages?[indexPath.row].image = placeholder
        self.view?.reloadCollection(indexPath: indexPath)
    }
}

extension ReportPresenter: ImagePickerDelegate {
    func didSelectImage(image: UIImage) {
        guard let indexPath = self.indexPath else  { return }
        self.arrayDamagedImages?[indexPath.row].image = image
        self.view?.reloadCollection(indexPath: indexPath)
    }
    
    func didCancel() {
        ///
    }
}
