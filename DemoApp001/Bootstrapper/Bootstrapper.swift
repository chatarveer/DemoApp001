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
    
    static func initialize(windowScene: UIWindowScene) {
        instance = Bootstrapper(window: makeNewWindow(windowScene: windowScene))
        instance!.bootstrap()
    }
    
    private static func makeNewWindow(windowScene: UIWindowScene) -> UIWindow {
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        return window
    }
    
    mutating func bootstrap() {
        let controller = HomeRouter.createModule()
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
