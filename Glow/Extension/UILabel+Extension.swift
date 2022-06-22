//
//  UILabel+Extension.swift
//  Glow
//
//  Created by Pushpa Yadav on 25/10/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setUp(title: String, font: UIFont, textColor: UIColor, noOfLine: Int) {
        self.text = title
        self.font = font
        self.textColor = textColor
        self.numberOfLines = noOfLine
    }
    
    func setUp(title: String, font: UIFont, textColor: UIColor, noOfLine: Int, textAlignment: NSTextAlignment) {
        self.text = title
        self.font = font
        self.textColor = textColor
        self.numberOfLines = noOfLine
        self.textAlignment = textAlignment
    }
    
    func underline() {
            if let textString = self.text {
              let attributedString = NSMutableAttributedString(string: textString)
                attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                              value: NSUnderlineStyle.single.rawValue,
                                              range: NSRange(location: 0, length: attributedString.length))
              attributedText = attributedString
            }
        }
}
    
    class PaddingLabel: UILabel {

        var edgeInset: UIEdgeInsets = .zero

        override func drawText(in rect: CGRect) {
            let insets = UIEdgeInsets.init(top: edgeInset.top, left: edgeInset.left, bottom: edgeInset.bottom, right: edgeInset.right)
            super.drawText(in: rect.inset(by: insets))
        }

        override var intrinsicContentSize: CGSize {
            let size = super.intrinsicContentSize
            return CGSize(width: size.width + edgeInset.left + edgeInset.right, height: size.height + edgeInset.top + edgeInset.bottom)
        }
}

class UnderlinedLabel: UILabel {

override var text: String? {
    didSet {
        guard let text = text else { return }
        let textRange = NSRange(location: 0, length: text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.underlineStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: textRange)
        // Add other attributes if needed
        self.attributedText = attributedText
        }
    }
}
