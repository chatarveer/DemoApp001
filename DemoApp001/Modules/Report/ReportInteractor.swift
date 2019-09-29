//
//  ReportInteractor.swift
//  DemoApp001
//
//  Created Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import UIKit

class ReportInteractor: ReportInteractorInputProtocol {
    
    weak var presenter: ReportInteractorOutputProtocol?
    
    func getDamagedImages() {
        //Ideally here would be API call which will get object from server of last state.
        let placeholder = UIImage.init(named: "placeholder")
        
        let damagedImageFront = DamagedImage(image: placeholder, type: .front)
        let damagedImageBack = DamagedImage(image: placeholder, type: .back)
        let damagedImageLeft = DamagedImage(image: placeholder, type: .left)
        let damagedImageRight = DamagedImage(image: placeholder, type: .right)
        
        let arrayDamagedImages = [damagedImageFront, damagedImageBack, damagedImageLeft, damagedImageRight]
        self.presenter?.damagedImages(arrayDamagedImages: arrayDamagedImages)
    }
    
    func submit(damagedComplain: DamagedComplainRequest) {
        //Submit complain to server
    }
}
