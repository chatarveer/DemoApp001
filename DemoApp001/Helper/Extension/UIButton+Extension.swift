//
//  UIButton+Extension.swift
//  DemoApp001
//
//  Created by Veer Suthar on 29/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    //    func setButtonImage(UIImage: AssetIdentifier) {
    //        self.setImage(UIImage(assetIdentifier: assetIdentifier), for: .normal)
    //
    //    }
    func moveImageLeftTextCenter(image: UIImage, imagePadding: CGFloat, renderingMode: UIImage.RenderingMode) {
        self.setImage(image.withRenderingMode(renderingMode), for: .normal)
        guard let imageViewWidth = self.imageView?.frame.width else {return}
        guard let titleLabelWidth = self.titleLabel?.intrinsicContentSize.width else {return}
        self.contentHorizontalAlignment = .left
        let imageLeft = imagePadding - imageViewWidth / 2
        let titleLeft = (bounds.width - titleLabelWidth) / 2 - imageViewWidth
        imageEdgeInsets = UIEdgeInsets(top: 0.0, left: imageLeft, bottom: 0.0, right: 0.0)
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: titleLeft, bottom: 0.0, right: 0.0)
    }
    
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        let writingDirection = UIApplication.shared.userInterfaceLayoutDirection
        let factor: CGFloat = writingDirection == .leftToRight ? 1 : -1
        
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount*factor, bottom: 0, right: insetAmount*factor)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount*factor, bottom: 0, right: -insetAmount*factor)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
    
    func makeItRound() {
        self.layer.cornerRadius = self.bounds.height / 2
    }
    
    func cadoButtonDim(dimWithAlphaComponent: CGFloat, _ isUserInteractionEnabled: Bool = true, _ isEnabled: Bool = true) {
        self.backgroundColor = UIColor.red.withAlphaComponent(dimWithAlphaComponent)
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.isEnabled = isEnabled
    }
    
    func cadoButtonNormal(_ isUserInteractionEnabled: Bool = true, _ isEnabled: Bool = true) {
        self.backgroundColor = UIColor.red
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.isEnabled = isEnabled
    }
    
    func setBorderColor(_ color: UIColor) {
        self.layer.borderColor = color.cgColor
    }
    
    func setBorderWidth(_ width: CGFloat) {
        self.layer.borderWidth = width
    }
}
