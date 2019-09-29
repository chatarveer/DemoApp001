//
//  SetupViews.swift
//  DemoApp001
//
//  Created by Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation

/// Protocol to be implemented by every View Controller of Project
protocol SetupViewController {
    
    /// Method to be implemented by ViewController to setup initial view and required registeration
    func setup()
    
    /// Method to be called to setup navigation bar
    func setupNavigation()
    
    /// Method to be called to make any network call on view load
    func networkRequests()
}

/// Protocol to be implemented by every Cell of Project
protocol SetupCell {
    /// Method used to setup cell values
    /// - Parameter object: object to be passed to cell to render it
    func configureCell<T>(object: T)
}
