//
//  MockReportInteractor.swift
//  DemoApp001Tests
//
//  Created by Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation

@testable import DemoApp001
class MockReportInteractor : ReportInteractorInputProtocol {
    var presenter: ReportInteractorOutputProtocol?
    
    func getDamagedImages() {
        let damagedImageFront = DamagedImage(image: nil, type: .front)
        let damagedImageBack = DamagedImage(image: nil, type: .back)
        let damagedImageLeft = DamagedImage(image: nil, type: .left)
        let damagedImageRight = DamagedImage(image: nil, type: .right)
        
        let arrayDamagedImages = [damagedImageFront, damagedImageBack, damagedImageLeft, damagedImageRight]
        self.presenter?.damagedImages(arrayDamagedImages: arrayDamagedImages)
    }
    
    func submit(damagedComplain: DamagedComplainRequest) {
        ///
    }    
}
