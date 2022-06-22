//
//  UIButton+Extension.swift
//  Glow
//
//  Created by Pushpa Yadav on 26/10/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

extension UIButton {
    
    // MARK: - Basic setup
    
    func setUp(title: String, font: UIFont, textColor: UIColor, bgColor: UIColor, radius: CGFloat = 0) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = bgColor
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        
        if #available(iOS 15, *) {
//            var attributedString = AttributedString.init(title)
//            attributedString.setAttributes(AttributeContainer([NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor: textColor]))
//            let attrStr = NSAttributedString(attributedString)
//            self.setAttributedTitle(attrStr, for: .normal)
        }
    }
    
    // MARK: - Checkbox setup
    
    func setUpCheckBox() {
        self.setTitle("", for: .normal)
        self.setTitle("", for: .selected)
        self.setImage(UIImage(named: "checkbox"), for: .normal)
        self.setImage(UIImage(named: "checkboxCheck"), for: .selected)
    }
    
    // MARK: - Blank setup
    
    func setUpBlank() {
        self.setTitle("", for: .normal)
    }
    
    // MARK: - Radio button setup
    
    func setUpRadioButton() {
        self.setTitle("", for: .normal)
        self.setTitle("", for: .selected)
        self.setImage(UIImage(named: "radio"), for: .normal)
        self.setImage(UIImage(named: "radioSelected"), for: .selected)
    }
}
