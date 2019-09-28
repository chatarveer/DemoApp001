//
//  Bootstrapper.swift
//  DemoApp001
//
//  Created by Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation
import UIKit

struct Bootstrapper {
    
    var window: UIWindow
    static var instance: Bootstrapper?
    
    static func initialize(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) {
        instance = Bootstrapper(window: makeNewWindow())
        instance!.bootstrap()
    }
    
    private static func makeNewWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.white
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window = window
        }
        return window
    }
    
    mutating func bootstrap() {
        let controller = ReportRouter.createModule()
        let navigationController = UINavigationController(rootViewController: controller)
        if #available(iOS 13.0, *) {
            navigationController.modalPresentationStyle = .fullScreen
        }
        self.window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    static func getWindow() -> UIWindow? {
        return instance!.window
    }
}
