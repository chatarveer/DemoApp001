//
//  PlaceholderTextView.swift
//  DemoApp001
//
//  Created by Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation
import UIKit

class PlaceholderTextView: UITextView {
    
    @IBInspectable var placeholderColor: UIColor = UIColor.lightGray
    @IBInspectable var placeholderText: String = ""
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    override var font: UIFont? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var contentInset: UIEdgeInsets {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var textAlignment: NSTextAlignment {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var text: String? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var attributedText: NSAttributedString? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    private func setUp() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.textChanged(notification:)),
                                               name: Notification.Name("UITextViewTextDidChangeNotification"),
                                               object: nil)
    }
    
    @objc func textChanged(notification: NSNotification) {
        setNeedsDisplay()
    }
    
    func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        var x = contentInset.left + 4.0
        var y = contentInset.top  + 9.0
        let w = frame.size.width - contentInset.left - contentInset.right - 16.0
        let h = frame.size.height - contentInset.top - contentInset.bottom - 16.0
        
        if let style = self.typingAttributes[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle {
            x += style.headIndent
            y += style.firstLineHeadIndent
        }
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
    override func draw(_ rect: CGRect) {
        guard let text = self.text,
            let font = self.font else {
                return
        }
        
        let fontKey = NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue)
        let colorKey = NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue)
        let paragraphKey = NSAttributedString.Key(rawValue: NSAttributedString.Key.paragraphStyle.rawValue)
        if text.isEmpty && !placeholderText.isEmpty {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = textAlignment
            let attributes: [NSAttributedString.Key: Any] = [
                fontKey: font,
                colorKey: placeholderColor,
                paragraphKey: paragraphStyle]
            
            placeholderText.draw(in: placeholderRectForBounds(bounds: bounds), withAttributes: attributes)
        }
        super.draw(rect)
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
