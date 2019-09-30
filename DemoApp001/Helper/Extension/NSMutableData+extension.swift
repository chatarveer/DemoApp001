//
//  NSMutableData+extension.swift
//  DemoApp001
//
//  Created by Veer Suthar on 30/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
