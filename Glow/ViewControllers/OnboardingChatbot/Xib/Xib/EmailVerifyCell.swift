//
//  EmailVerifyCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 24/11/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class EmailVerifyCell: UITableViewCell {
    
    static let identifier = "EmailVerifyCell"
    
    // MARK: - Outlet
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var vwSubmit: UIView!
    @IBOutlet weak var lblSubmit: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblEmail.setUp(title: "Email".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
      
        txtEmail.backgroundColor = UIColor.AppColors.navigationBackground
        txtEmail.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
        
        vwSubmit.backgroundColor = UIColor.AppColors.themeColor
        vwSubmit.layer.cornerRadius = Constant.buttonRadius
        vwSubmit.clipsToBounds = true
        txtEmail.text = nil
        lblSubmit.setUp(title: "Submit".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, noOfLine: 1)
        btnSubmit.setUpBlank()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblEmail.font = UIFont.Poppins.medium.size(FontSize.body_13)
        txtEmail.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
        lblSubmit.font = UIFont.Poppins.medium.size(FontSize.body_17)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
