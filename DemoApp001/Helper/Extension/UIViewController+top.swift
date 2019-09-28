//
//  UIViewController+top.swift
//  DemoApp001
//
//  Created by Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    static func top() -> UIViewController {
        guard let window = Bootstrapper.getWindow() else { fatalError("No window present in app?")  }
        guard let rootViewController = window.rootViewController else { fatalError("No view controller present in app?") }
        var result = rootViewController
        while let vc = result.presentedViewController {
            result = vc
        }
        return result
    }
}

