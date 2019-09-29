//
//  UIView+Extension.swift
//  DemoApp001
//
//  Created by Veer Suthar on 29/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var ending: CGPoint { return CGPoint(x: frame.origin.x + frame.width, y: frame.origin.y + frame.height) }
    var viewWidth: CGFloat { return frame.width }
    var viewHeight: CGFloat { return frame.height }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func roundCorners(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func border(width: CGFloat, color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    class func fromNib<T: UIView>() -> T {
        let view = Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as? T
        return view!
    }
    
    func makeCircular() {
        self.layer.cornerRadius = self.frame.size.width / 2
        //self.clipsToBounds = true
    }
    
    func shake() {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
