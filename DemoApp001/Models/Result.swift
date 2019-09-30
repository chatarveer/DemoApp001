//
//  Result.swift
//  DemoApp001
//
//  Created by Veer Suthar on 30/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation

public struct Result<T> {
    public let successResponse: T?
    public let failureResponse: Error?
    
    init(success: T) {
        successResponse = success
        failureResponse = nil
    }
    
    init(failure: Error) {
        successResponse = nil
        failureResponse = failure
    }
}
