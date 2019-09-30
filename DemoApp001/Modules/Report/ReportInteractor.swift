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
        
        var successCount = 0
        
        for image in damagedComplain.damagedImages {
            if let imageCompressed = image.image?.jpeg(.medium),
                let imageData = imageCompressed.jpegData(compressionQuality: 0.2) {
                //FIXME: Pass Constant URL
                ImageUploader.shared.uploadImage(imageData, urlToUpladImg: "https://api.cloudinary.com/v1_1/dk6hqmxjl/image/upload") { response in
                    
                    response.successResponse.flatMap { (data, response) in
                        successCount = successCount + 1
                        if successCount == damagedComplain.damagedImages.count {
                            self.presenter?.reportSubmittedSuccessfully()
                        }
                    }
                    
                    //Error
                    response.failureResponse.flatMap { error in
                        self.presenter?.reportSubmissionFailed(error: error)
                    }
                }
            }
        }
        
    }
}



enum JPEGQuality: CGFloat {
    case lowest  = 0
    case low     = 0.25
    case medium  = 0.5
    case high    = 0.75
    case highest = 1
}
