//
//  MockReportViewController.swift
//  DemoApp001Tests
//
//  Created by Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation

@testable import DemoApp001
class MockReportViewController : ReportViewProtocol {
    var presenter: ReportPresenterProtocol?
    
    func showLoader() {
        ///
    }
    
    func hideLoader() {
        ///
    }
    
    func selectPickerType() {
        ///
    }
    
    func reloadCollection() {
        ///
    }
    
    func reloadCollection(indexPath: IndexPath) {
        ///
    }
    
    func updateCommentViewToDefaultState() {
        ///
    }
    
    func commentInvalid() {
        ///
    }
    
    func imageInvalid(indexPath: IndexPath) {
        ///
    }
}
