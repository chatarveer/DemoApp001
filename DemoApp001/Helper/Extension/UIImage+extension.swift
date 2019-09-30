//
//  UIImage+extension.swift
//  DemoApp001
//
//  Created by Veer Suthar on 30/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func jpeg(_ quality: JPEGQuality) -> UIImage? {
        guard let data = self.jpegData(compressionQuality: quality.rawValue),
            let image = UIImage(data: data)
            else { return nil }
        return image
    }
}
