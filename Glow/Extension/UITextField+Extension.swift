//
//  UITextField+Extension.swift
//  Glow
//
//  Created by Pushpa Yadav on 05/11/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class AppTextField: UITextField {

    let phonePadding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    let padPadding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIDevice.current.userInterfaceIdiom == .phone ?
        bounds.inset(by: phonePadding) : bounds.inset(by: padPadding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIDevice.current.userInterfaceIdiom == .phone ?
        bounds.inset(by: phonePadding) : bounds.inset(by: padPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIDevice.current.userInterfaceIdiom == .phone ?
        bounds.inset(by: phonePadding) : bounds.inset(by: padPadding)
    }
}
