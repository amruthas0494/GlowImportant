//
//  LoginCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 13/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class LoginCell: UITableViewCell {

    static let identifier = "LoginCell"
    
    // MARK: - Outlet
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var vwLoginToAccount: UIView!
    @IBOutlet weak var lblLoginToAccount: UILabel!
    @IBOutlet weak var btnLoginToAccount: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        [lblEmail, lblPassword].forEach { lbl in
            lbl?.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        }
        [txtEmail, txtPassword].forEach { txt in
            txt?.backgroundColor = UIColor.AppColors.navigationBackground
            txt?.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
        }
        lblEmail.text = "Email".Chatbotlocalized()
        lblPassword.text = "Password".Chatbotlocalized()
        
        txtEmail.keyboardType = .emailAddress
        txtPassword.isSecureTextEntry = true
        
        vwLoginToAccount.backgroundColor = UIColor.AppColors.themeColor
        vwLoginToAccount.layer.cornerRadius = Constant.buttonRadius
        vwLoginToAccount.clipsToBounds = true
        
        lblLoginToAccount.setUp(title: "Login".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, noOfLine: 1)
        btnLoginToAccount.setUpBlank()
        
/*
        vwForgotPassword.backgroundColor = UIColor.AppColors.themeColor
        vwForgotPassword.layer.cornerRadius = Constant.buttonRadius
        vwForgotPassword.clipsToBounds = true
        
        lblForgotPassword.setUp(title: "Forgot Password?", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, noOfLine: 1)
*/
        btnForgotPassword.setUp(title: "Forgot Password?".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: UIColor.AppColors.themeColor, bgColor: .clear)
//        btnForgotPassword.setUpBlank()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        [lblEmail, lblPassword].forEach { lbl in
            lbl?.font = UIFont.Poppins.medium.size(FontSize.body_13)
        }
        [txtEmail, txtPassword].forEach { txt in
            txt?.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
        }
        lblLoginToAccount.font = UIFont.Poppins.medium.size(FontSize.body_17)
        btnForgotPassword.titleLabel?.font = UIFont.Poppins.medium.size(FontSize.body_17)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
