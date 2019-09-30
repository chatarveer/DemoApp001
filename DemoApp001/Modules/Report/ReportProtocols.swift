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
    
    /// Variable to hold images of damaged vehicles sides.
    var arrayDamagedImages: [DamagedImage]? { get set }
    
    /// Variable to hold index path user selected.
    var indexPath: IndexPath? { get set }
    
    /// Variable to hold comment user has entered.
    var comment: String? { get set }
    
    /// Call this function to set comment .
    /// - Parameter comment: Parameter to pass comment from textview to comment variable
    func set(comment: String)
    
    func selectedIndex(indexPath: IndexPath)
    func removeImage(indexPath: IndexPath)
    
    /// Call this function when to open Image Picker.
    /// - Parameter sourceType: This enum decides whether to use gallery or camera
    func openImagePicker(sourceType: ImagePickerType)
    func getDamagedImages()
    
    func submit()
    
    func validate(image: DamagedImage) -> (image: DamagedImage, isValid: Bool)
}

//MARK: Interactor -
protocol ReportInteractorOutputProtocol: class {
    
    /* Interactor -> Presenter */
    
    func damagedImages(arrayDamagedImages: [DamagedImage])
    
    func reportSubmittedSuccessfully()
    func reportSubmissionFailed(error: Error)
    
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
    
    /**
     Call this function to start Loader.
     */
    func showLoader()
    
    /**
     Call this function to stop Loader.
     */
    func hideLoader()
    
    func selectPickerType(shouldShowDelete: Bool, for indexPath: IndexPath)
    func reloadCollection()
    func reloadCollection(indexPath: IndexPath)
    
    func updateCommentViewToDefaultState()
    
    func commentInvalid()
    func imageInvalid(indexPath: IndexPath)
    
    func reportSubmittedSuccessfully()
    func reportSubmissionFailed(error: Error)
}
