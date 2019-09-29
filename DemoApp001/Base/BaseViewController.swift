//
//  BaseViewController.swift
//  DemoApp001
//
//  Created by Veer Suthar on 29/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if #available(iOS 13.0, *) {
            self.modalPresentationStyle = .fullScreen
        }
    }
}
