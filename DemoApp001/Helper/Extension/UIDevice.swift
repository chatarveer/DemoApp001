//
//  UIDevice.swift
//  DemoApp001
//
//  Created by Veer Suthar on 29/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    enum DeviceType {
        case iPhone4
        case iPhone5
        case iPhone8
        case iPhone8Plus
        case iPhoneX
        case iPhoneXSMax
        case iPad
        case TV
        case carPlay
        case unspecified
        
        var isPhone: Bool {
            return [.iPhone4, .iPhone5, .iPhone8, .iPhone8Plus].contains(self)
        }
    }
    
    var deviceType: DeviceType? {
        switch UIDevice.current.userInterfaceIdiom {
        case .tv:
            return .TV
        case .pad:
            return .iPad
        case .phone:
            let screenSize = UIScreen.main.bounds.size
            let height = max(screenSize.width, screenSize.height)
            
            switch height {
            case 480:
                return .iPhone4
            case 568:
                return .iPhone5
            case 667:
                return .iPhone8
            case 736:
                return .iPhone8Plus
            case 812:
                return .iPhoneX
            case 896:
                return .iPhoneXSMax
            default:
                return nil
            }
        case .unspecified:
            return .unspecified
        case .carPlay:
            return .carPlay
        @unknown default:
            return .iPhone4
        }
    }
}
