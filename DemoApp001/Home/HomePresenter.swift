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
    
    init(interface: HomeViewProtocol, interactor: HomeInteractorInputProtocol?, router: HomeWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func selectedIndex(indexPath: IndexPath) {
        self.view?.selectPickerType()
    }
    
    func openImagePicker(sourceType: ImagePickerType) {
        ImagePickerManager.shared.openImagePicker(sourceType: sourceType, delegate: self)
    }
}

extension HomePresenter: ImagePickerDelegate {
    func didSelectImage(image: UIImage) {
        ///
    }
    
    func didCancel() {
        ///
    }
}
