//
//  DamagedImage.swift
//  DemoApp001
//
//  Created by Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation
import UIKit

enum DamagedImageType {
    case front
    case back
    case left
    case right
}

//Ideally API should be integrated and instead of UIImage, there should be URL in model.
struct DamagedImage {
    var image: UIImage?
    let type: DamagedImageType?
}
