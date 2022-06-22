//
//  UIView+Extension.swift
//  Glow
//
//  Created by Pushpa Yadav on 25/10/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

extension UIView {
    func subview<T>(of type: T.Type) -> T? {
        return subviews.compactMap { $0 as? T ?? $0.subview(of: type) }.first
    }
    
//    static var identifier: String {
//        return String(describing: self)
//    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func roundCorners(radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
//    func roundCorners(radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
//        self.layer.cornerRadius = radius
//        self.layer.borderWidth = borderWidth
//        self.layer.borderColor = borderColor.cgColor
//    }
  
    
    
    
}
