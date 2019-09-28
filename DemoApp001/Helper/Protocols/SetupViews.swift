//
//  SetupViews.swift
//  DemoApp001
//
//  Created by Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation

protocol SetupViewController {
    func setup()
    func setupNavigation()
    func networkRequests()
}

protocol SetupCell {
    func configureCell<T>(object: T)
}
