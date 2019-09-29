//
//  ReportProtocols.swift
//  DemoApp001
//
//  Created Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation

//MARK: Wireframe -
protocol ReportWireframeProtocol: class {
    
}
//MARK: Presenter -
protocol ReportPresenterProtocol: class {
    
    var interactor: ReportInteractorInputProtocol? { get set }
    var arrayDamagedImages: [DamagedImage]? { get set }
    var indexPath: IndexPath? { get set }
    var comment: String? { get set }
    
    func set(comment: String)
    
    func selectedIndex(indexPath: IndexPath)
    func removeImage(indexPath: IndexPath)
    func openImagePicker(sourceType: ImagePickerType)
    func getDamagedImages()
    
    func submit()
    
    func validate(image: DamagedImage) -> (image: DamagedImage, isValid: Bool)
}

//MARK: Interactor -
protocol ReportInteractorOutputProtocol: class {
    
    /* Interactor -> Presenter */
    
    func damagedImages(arrayDamagedImages: [DamagedImage])
}

protocol ReportInteractorInputProtocol: class {
    
    var presenter: ReportInteractorOutputProtocol?  { get set }
    
    /* Presenter -> Interactor */
    func getDamagedImages()
    func submit(damagedComplain: DamagedComplainRequest)
}

//MARK: View -
protocol ReportViewProtocol: class {
    
    var presenter: ReportPresenterProtocol?  { get set }
    
    /* Presenter -> ViewController */
    
    func showLoader()
    func hideLoader()
    
    func selectPickerType(shouldShowDelete: Bool, for indexPath: IndexPath)
    func reloadCollection()
    func reloadCollection(indexPath: IndexPath)

    func updateCommentViewToDefaultState()

    func commentInvalid()
    func imageInvalid(indexPath: IndexPath)
}
