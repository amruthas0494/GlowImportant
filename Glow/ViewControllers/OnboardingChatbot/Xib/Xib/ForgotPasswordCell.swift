//
//  ForgotPasswordCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 13/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class ForgotPasswordCell: UITableViewCell {
    
    static let identifier = "ForgotPasswordCell"
    
    // MARK: - Outlet
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var vwResetLink: UIView!
    @IBOutlet weak var lblResetLink: UILabel!
    @IBOutlet weak var btnResetLink: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblEmail.setUp(title: "Email".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        
        txtEmail.backgroundColor = UIColor.AppColors.navigationBackground
        txtEmail.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
        
        txtEmail.keyboardType = .emailAddress
        
        vwResetLink.backgroundColor = UIColor.AppColors.themeColor
        vwResetLink.layer.cornerRadius = Constant.buttonRadius
        vwResetLink.clipsToBounds = true
        
        lblResetLink.setUp(title: "Send password reset link".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, noOfLine: 1)
        btnResetLink.setUpBlank()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblEmail.font = UIFont.Poppins.medium.size(FontSize.body_13)
        txtEmail.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
        lblResetLink.font = UIFont.Poppins.medium.size(FontSize.body_17)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
