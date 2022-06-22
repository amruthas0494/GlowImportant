//
//  String+Extension.swift
//  Glow
//
//  Created by Pushpa Yadav on 25/10/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

extension String {
    func mutableString(color: UIColor, font: UIFont, location: Int, lenght: Int) -> NSMutableAttributedString  {
        let mutableString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font:font])
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: location,length: lenght))
        return mutableString
    }
    func boldAttributedText(boldString: String, font: UIFont, boldStringFontSize: Float) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self,
                                                         attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.Poppins.semiBold.size(CGFloat(boldStringFontSize))]
        let range = (self as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
    
    var trimWhiteSpace: String {
        get {
            let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed
        }
    }
    var leastOneLowerCase: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z]).{1,}$").evaluate(with: self)
    }
    
    var leastOneUpperCase: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z]).{1,}$").evaluate(with: self)
    }
    
    var leastOneSpecialCharacter: Bool {
        //        return NSPredicate(format: "SELF MATCHES %@", "^(?=.*[!@#$&%*()_+|~-=`{}[]:;'<>?,./]).{1,}$").evaluate(with: self)
        return NSPredicate(format: "SELF MATCHES %@", "^(?=.*[!@#$&*?.,/{}<>]).{1,}$").evaluate(with: self)
    }
    
    var leastOneDigit: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "^(?=.*[0-9]).{1,}$").evaluate(with: self)
    }
    
    var leastEightCharacter: Bool {
        let filteredString = self.trimmingCharacters(in: CharacterSet.whitespaces)
        return filteredString.count > 7
    }
    
    func isPasswordStrong() -> Bool {
        return self.leastOneLowerCase && self.leastOneUpperCase && self.leastOneSpecialCharacter && self.leastOneDigit && self.leastEightCharacter
    }
    func isValidPassword() -> (hasLowerCase: Bool, hasUpperCase: Bool, hasSpecialCharacter: Bool, hasDigit: Bool, hasEightCharacter: Bool) {
        return (self.leastOneLowerCase, self.leastOneUpperCase, self.leastOneSpecialCharacter, self.leastOneDigit, self.leastEightCharacter)
    }
    
    //    func isValidPassword() -> Bool {
    //        let passwordRegEx  = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
    //        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
    //        return passwordPred.evaluate(with: self)
    //    }
    func isValidPhoneNumber(phoneNumber: String) -> Bool {
        let phoneNumberCount = phoneNumber.count
        if phoneNumberCount >=  10  {
            return true
        }else {
            return false
        }
    }
    
    var digits:String {
        let isContainsPlus = self.contains("+")
        let preSymbol = isContainsPlus ? "+" : ""
        let digits = preSymbol + self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return digits
    }
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: self)
    }
    
    func validateEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPhone() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
