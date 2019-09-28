//
//  HomePresenter.swift
//  DemoApp001
//
//  Created Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import UIKit

class HomePresenter: HomePresenterProtocol, HomeInteractorOutputProtocol {
    
    weak private var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    private let router: HomeWireframeProtocol
    
    var arrayDamagedImages: [DamagedImage]?
    var indexPath: IndexPath?
    
    init(interface: HomeViewProtocol, interactor: HomeInteractorInputProtocol?, router: HomeWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func selectedIndex(indexPath: IndexPath) {
        self.indexPath = indexPath
        self.view?.selectPickerType()
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
}

extension HomePresenter: ImagePickerDelegate {
    func didSelectImage(image: UIImage) {
        print("Image is selected \(image)")
        guard let indexPath = self.indexPath else  { return }
        self.arrayDamagedImages?[indexPath.row].image = image
        self.view?.reloadCollection()
    }
    
    func didCancel() {
        ///
    }
}
