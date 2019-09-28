//
//  HomeProtocols.swift
//  DemoApp001
//
//  Created Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation

//MARK: Wireframe -
protocol HomeWireframeProtocol: class {
    
}
//MARK: Presenter -
protocol HomePresenterProtocol: class {
    
    var interactor: HomeInteractorInputProtocol? { get set }
    var arrayDamagedImages: [DamagedImage]? { get set }
    var indexPath: IndexPath? { get set }
    var comment: String? { get set }
    
    func set(comment: String)
    
    func selectedIndex(indexPath: IndexPath)
    func openImagePicker(sourceType: ImagePickerType)
    func getDamagedImages()
    
    func submit()
    
    func validate(image: DamagedImage) -> (image: DamagedImage, isValid: Bool)
}

//MARK: Interactor -
protocol HomeInteractorOutputProtocol: class {
    
    /* Interactor -> Presenter */
    
    func damagedImages(arrayDamagedImages: [DamagedImage])
}

protocol HomeInteractorInputProtocol: class {
    
    var presenter: HomeInteractorOutputProtocol?  { get set }
    
    /* Presenter -> Interactor */
    func getDamagedImages()
    func submit(damagedComplain: DamagedComplainRequest)
}

//MARK: View -
protocol HomeViewProtocol: class {
    
    var presenter: HomePresenterProtocol?  { get set }
    
    /* Presenter -> ViewController */
    
    func showLoader()
    func hideLoader()
    
    func selectPickerType()
    func reloadCollection()
    func reloadCollection(indexPath: IndexPath)

    func updateCommentViewToDefaultState()

    func commentInvalid()
    func imageInvalid(indexPath: IndexPath)
}
