//
//  File.swift
//  Glow
//
//  Created by Pushpa Yadav on 25/10/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

struct FontSize {
    
    static let largeTitle_24: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 24 : 48
    static let title1_23: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 23 : 46
    static let title2_21: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 21 : 42
    static let title3_20: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 20 : 40
    static let headline_19: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 19 : 38
    static let body_17: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 17 : 34
    static let body_18: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 18 : 36
    static let body_15: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 15 : 30
    static let body_14: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 14 : 28
    static let body_16: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 16 : 32
    static let body_13: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 13 : 26
    static let subtitle_12: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 12 : 24
    static let subtitle_11: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 11 : 22
} 

extension UIFont {
    enum Poppins: String {
        case extraBold = "Poppins-ExtraBold"
        case extraLight = "Poppins-ExtraLight"
        case black = "Poppins-Black"
        case bold = "Poppins-Bold"
        case light = "Poppins-Light"
        case medium = "Poppins-Medium"
        case regular = "Poppins-Regular"
        case semiBold = "Poppins-SemiBold"
        case thin = "Poppins-Thin"
        
        func fixSize(_ size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
        }
        
        func size(_ size: CGFloat) -> UIFont {
            let pointToIncrease = Glow.sharedInstance.prefFontSize == 0 ? 0 : Glow.sharedInstance.prefFontSize - 17
            let sizeIs = size + CGFloat(pointToIncrease) //CGFloat(Glow.sharedInstance.prefFontSize - 17)
            return UIFont(name: self.rawValue, size: sizeIs) ?? UIFont.systemFont(ofSize: sizeIs)
        }
    }
}
