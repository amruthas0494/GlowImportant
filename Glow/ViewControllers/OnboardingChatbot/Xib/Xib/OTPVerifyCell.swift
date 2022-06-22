//
//  OTPVerifyCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 25/11/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class OTPVerifyCell: UITableViewCell {
    
    static let identifier = "OTPVerifyCell"
    
    // MARK: - Outlets
    @IBOutlet weak var txtOTP1: UITextField!
    @IBOutlet weak var txtOTP2: UITextField!
    @IBOutlet weak var txtOTP3: UITextField!
    @IBOutlet weak var txtOTP4: UITextField!
    @IBOutlet weak var txtOTP5: UITextField!
    @IBOutlet weak var txtOTP6: UITextField!
    @IBOutlet weak var vwSubmit: UIView!
    @IBOutlet weak var lblSubmit: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var vwResendOTP: UIView!
    @IBOutlet weak var lblResendOTP: UILabel!
    @IBOutlet weak var btnResendOTP: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        [txtOTP1, txtOTP2, txtOTP3, txtOTP4, txtOTP5, txtOTP6].forEach { txt in
            txt?.layer.cornerRadius = 4
            txt?.clipsToBounds = true
            txt?.layer.borderWidth = 1
            txt?.layer.borderColor = UIColor.AppColors.themeColor.cgColor
            txt?.textAlignment = .center
            txt?.delegate = self
            txt?.keyboardType = .numberPad
            txt?.backgroundColor = UIColor.AppColors.navigationBackground
            txt?.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
            txt?.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
            
        }
        vwSubmit.backgroundColor = UIColor.AppColors.themeColor
        vwSubmit.layer.cornerRadius = Constant.buttonRadius
        vwSubmit.clipsToBounds = true
        
        vwResendOTP.backgroundColor = UIColor.AppColors.themeColor
        vwResendOTP.layer.cornerRadius = Constant.buttonRadius
        vwResendOTP.clipsToBounds = true
        
        lblSubmit.setUp(title: "Submit".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: .white, noOfLine: 1)
        btnSubmit.setUpBlank()
        
        lblResendOTP.setUp(title: "Resend OTP".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: .white, noOfLine: 1)
        btnResendOTP.setUpBlank()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        [txtOTP1, txtOTP2, txtOTP3, txtOTP4, txtOTP5, txtOTP6].forEach { txt in
            txt?.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
        }
        lblSubmit.font = UIFont.Poppins.medium.size(FontSize.body_15)
        lblResendOTP.font = UIFont.Poppins.medium.size(FontSize.body_15)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

// MARK: - UITextFieldDelegate
extension OTPVerifyCell: UITextFieldDelegate {
    
    @objc func textFieldDidChange(textField: UITextField) {
        let text = textField.text
        if  text?.count == 1 {
            switch textField{
            case txtOTP1:
                txtOTP2.becomeFirstResponder()
            case txtOTP2:
                txtOTP3.becomeFirstResponder()
            case txtOTP3:
                txtOTP4.becomeFirstResponder()
            case txtOTP4:
                txtOTP5.becomeFirstResponder()
            case txtOTP5:
                txtOTP6.becomeFirstResponder()
            default:
                break
            }
        }
        if  text?.count == 0 {
            switch textField{
            case txtOTP1:
                txtOTP1.becomeFirstResponder()
            case txtOTP2:
                txtOTP2.becomeFirstResponder()
            case txtOTP3:
                txtOTP3.becomeFirstResponder()
            case txtOTP4:
                txtOTP4.becomeFirstResponder()
            case txtOTP5:
                txtOTP5.becomeFirstResponder()
            case txtOTP6:
                txtOTP6.becomeFirstResponder()
            default:
                break
            }
        }
        else{
            
        }
    }
}
