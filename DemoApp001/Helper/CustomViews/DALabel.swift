//
//  DALabel.swift
//  DemoApp001
//
//  Created by Veer Suthar on 29/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import UIKit

class DALabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customize()
        self.sharedInit()
    }
    
    func sharedInit() {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(self.showMenu)))
    }
    
    @objc func showMenu(sender: AnyObject?) {
        self.becomeFirstResponder()
        
        let menu = UIMenuController.shared
        
        if !menu.isMenuVisible {
            menu.setTargetRect(bounds, in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    override func copy(_ sender: Any?) {
        let board = UIPasteboard.general
        board.string = text
        let menu = UIMenuController.shared
        menu.setMenuVisible(false, animated: true)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.copy) {
            return true
        }
        return false
    }
}

extension DALabel {
    func customize() {
        
        var size: CGFloat = 0.0
        
        guard let type = UIDevice.current.deviceType
            else { return }
                
        switch type {
        case .iPhone4:
            size = 0.652173913
        case .iPhone5:
            size = 0.7717391304
        case .iPhone8:
            size = 0.90625
        case .iPhone8Plus:
            //NO Change in size as base size is iPhone 8 Plus
            size = 1.0
        case .iPhoneX:
            size = 1.1032608696
        case .iPhoneXSMax:
            size = 1.2173913043
        case .iPad:
            size = 1.0
        case .TV:
            size = 1.0
        case .carPlay:
            size = 1.0
        case .unspecified:
            print("Unknown device size")
        }
        
        let fontName = self.font.fontName
        let pointSize = self.font.pointSize
        
        self.font = UIFont(name: fontName, size: pointSize*size)
    }
}
