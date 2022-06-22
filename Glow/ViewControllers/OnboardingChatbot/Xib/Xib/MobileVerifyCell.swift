//
//  MobileVerifyCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 24/11/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class MobileVerifyCell: UITableViewCell {
    
    static let identifier = "MobileVerifyCell"
    
    // MARK: - Outlet
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var txtCountryCode: UITextField!
    
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var vwSubmit: UIView!
    @IBOutlet weak var lblSubmit: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblMobile.setUp(title: "Mobile Number".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        lblCountryCode.setUp(title: "+65".Chatbotlocalized(), font: UIFont.Poppins.semiBold.size(FontSize.body_15), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)

        txtMobile.backgroundColor = UIColor.AppColors.navigationBackground
        txtMobile.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
/*
        [txtMobile].forEach { txt in
            txt?.backgroundColor = UIColor.AppColors.navigationBackground
            txt?.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
            txt?.keyboardType = .numberPad
        }

   */
        vwSubmit.backgroundColor = UIColor.AppColors.themeColor
        vwSubmit.layer.cornerRadius = Constant.buttonRadius
        vwSubmit.clipsToBounds = true
        
        lblSubmit.setUp(title: "Submit".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: .white, noOfLine: 1)
        btnSubmit.setUpBlank()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblMobile.font = UIFont.Poppins.medium.size(FontSize.body_13)
        txtMobile.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
        lblSubmit.font = UIFont.Poppins.medium.size(FontSize.body_15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
