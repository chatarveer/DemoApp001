//
//  String+extension.swift
//  DemoApp001
//
//  Created by Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation

extension String {
    func trim() -> String {
        self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
