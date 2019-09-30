//
//  CGFloat.swift
//  DemoApp001
//
//  Created by Veer Suthar on 29/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation
import Foundation
import UIKit

public extension CGFloat {
    
    var half: CGFloat { return self / 2 }
    var double: CGFloat { return self * 2 }
    
    mutating func adjustHorizontalPosition() -> CGFloat {
        guard let type = UIDevice.current.deviceType
            else {
                // Unknown type
                return self
        }
        
        switch type {
        case .iPhone4:
            self = (self * 0.7729468599)
        case .iPhone5:
            self = (self * 0.5152979066)
        case .iPhone8:
            self = (self * 0.6038647343)
        case .iPhone8Plus:
            //NO Change in size as base size is iPhone 8 Plus
            break
        case .iPhoneX:
            self = (self * 0.9057971014)
        case .iPhoneXSMax:
            self = (self * 1.2173913043)
        case .iPad:
            //NO Change in size as base size is iPad
            break
        case .TV:
            print("TV size")
        case .carPlay:
            print("Carplay size")
        case .unspecified:
            print("Unknown device size")
        }
        
        return self
    }
    
    mutating func adjustVerticalPosition() {
        guard let type = UIDevice.current.deviceType
            else {
                // Unknown type
                return
        }
        
        switch type {
        case .iPhone4:
            print("iPhone 4 size")
            self = (self * 0.652173913)
        case .iPhone5:
            print("iPhone 5 size")
            self = (self * 0.7717391304)
        case .iPhone8:
            print("iPhone 8 size")
            self = (self * 0.90625)
        case .iPhone8Plus:
            //NO Change in size as base size is iPhone 8 Plus
            print("iPhone 8 Plus size")
        case .iPhoneX:
            print("iPhone X size")
            self = (self * 1.1032608696)
        case .iPhoneXSMax:
            print("iPhone Xs Max size")
            self = (self * 1.2173913043)
        case .iPad:
            break
        case .TV:
            print("TV size")
        case .carPlay:
            print("Carplay size")
        case .unspecified:
            print("Unknown device size")
        }
    }
}
