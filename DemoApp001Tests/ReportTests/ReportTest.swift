//
//  ReportTest.swift
//  DemoApp001Tests
//
//  Created by Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import XCTest


@testable import DemoApp001

class ReportTest: XCTestCase {
    
    let interface = MockReportViewController()
    let interactor = MockReportInteractor()
    let router = MockReportRouter()
    var presenter : ReportPresenter?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        presenter = ReportPresenter.init(interface: interface,
                                         interactor: interactor,
                                         router: router)
        interactor.presenter = presenter
        interface.presenter = presenter
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNilImagesViewLoad() {
        self.presenter?.getDamagedImages()
        guard let arrayDamagedImages = presenter?.arrayDamagedImages else {
            assertionFailure("arrayDamagedImages found nil")
            return
        }
        for value in arrayDamagedImages {
            assert(value.image == self.presenter?.placeholder, "\(value.type.getTitle()) found non-nil")
        }
    }
    
    func testFrontImage() {
        self.presenter?.getDamagedImages()
        guard let _ = presenter?.arrayDamagedImages else {
            assertionFailure("arrayDamagedImages found nil")
            return
        }
        
        let indexPath = IndexPath(row: 0, section: 0)
        self.presenter?.selectedIndex(indexPath: indexPath)
        
        let bundle = Bundle(for: DemoApp001Tests.self)
        if let imageFront = UIImage(named: "placeholder", in: bundle, compatibleWith: nil) {
            self.presenter?.didSelectImage(image: imageFront)
        }
        
        assert(presenter?.arrayDamagedImages?[indexPath.row].image != nil, "Front image is nil")
    }
    
    func testBackImage() {
        self.presenter?.getDamagedImages()
        guard let _ = presenter?.arrayDamagedImages else {
            assertionFailure("arrayDamagedImages found nil")
            return
        }
        
        let indexPath = IndexPath(row: 1, section: 0)
        self.presenter?.selectedIndex(indexPath: indexPath)
        
        let bundle = Bundle(for: DemoApp001Tests.self)
        if let imageBack = UIImage(named: "placeholder", in: bundle, compatibleWith: nil) {
            self.presenter?.didSelectImage(image: imageBack)
        }
        
        assert(presenter?.arrayDamagedImages?[indexPath.row].image != nil, "Front image is nil")
    }
    
    func testLeftImage() {
        self.presenter?.getDamagedImages()
        guard let _ = presenter?.arrayDamagedImages else {
            assertionFailure("arrayDamagedImages found nil")
            return
        }
        
        let indexPath = IndexPath(row: 2, section: 0)
        self.presenter?.selectedIndex(indexPath: indexPath)
        
        let bundle = Bundle(for: DemoApp001Tests.self)
        if let imageLeft = UIImage(named: "placeholder", in: bundle, compatibleWith: nil) {
            self.presenter?.didSelectImage(image: imageLeft)
        }
        
        assert(presenter?.arrayDamagedImages?[indexPath.row].image != nil, "Front image is nil")
    }
    
    func testRightImage() {
        self.presenter?.getDamagedImages()
        guard let _ = presenter?.arrayDamagedImages else {
            assertionFailure("arrayDamagedImages found nil")
            return
        }
        
        let indexPath = IndexPath(row: 3, section: 0)
        self.presenter?.selectedIndex(indexPath: indexPath)
        
        let bundle = Bundle(for: DemoApp001Tests.self)
        if let imageRight = UIImage(named: "placeholder", in: bundle, compatibleWith: nil) {
            self.presenter?.didSelectImage(image: imageRight)
        }
        
        assert(presenter?.arrayDamagedImages?[indexPath.row].image != nil, "Front image is nil")
    }
    
    
    func testAllImage() {
        self.presenter?.getDamagedImages()
        guard let _ = presenter?.arrayDamagedImages else {
            assertionFailure("arrayDamagedImages found nil")
            return
        }
        
        let bundle = Bundle(for: DemoApp001Tests.self)
        
        for value in 0...3 {
            let indexPath = IndexPath(row: value, section: 0)
            self.presenter?.selectedIndex(indexPath: indexPath)
            
            if let image = UIImage(named: "placeholder", in: bundle, compatibleWith: nil) {
                self.presenter?.didSelectImage(image: image)
            }
            
            assert(presenter?.arrayDamagedImages?[indexPath.row].image != self.presenter?.placeholder, "Image found nil at \(indexPath)")
        }
    }
    
    func testDeleteImage() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.presenter?.removeImage(indexPath: indexPath)
    }
    
    
    func testCommentNil() {
        self.presenter?.set(comment: "I have found crash on right side of car")
        guard let _ = self.presenter?.comment else {
            assertionFailure("Comment box is nil")
            return
        }
    }
    
    func testCommentEmpty() {
        self.presenter?.set(comment: "I have found crash on right side of car")
        guard let isValid = self.presenter?.validate(comment: self.presenter?.comment) else { fatalError("Presenter is not initialized properly") }
        assert(isValid, "Comment box is not populated")
    }
}
