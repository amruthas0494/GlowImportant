//
//  AgeCell.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 17/02/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class AgeCell: UITableViewCell, UITextFieldDelegate {

    static let identifier = "AgeCell"
    
    // MARK: - Outlet
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var vwSubmit: UIView!
    @IBOutlet weak var lblSubmit: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblAge.setUp(title: "Enter age".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        
        txtAge.backgroundColor = UIColor.AppColors.navigationBackground
        txtAge.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
        txtAge.keyboardType = .numberPad
       txtAge.delegate = self
      txtAge.becomeFirstResponder()
        
        vwSubmit.backgroundColor = UIColor.AppColors.themeColor
        vwSubmit.layer.cornerRadius = Constant.buttonRadius
        vwSubmit.clipsToBounds = true
        vwSubmit.isUserInteractionEnabled = true

        lblSubmit.setUp(title: "Submit".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, noOfLine: 1)
        btnSubmit.setUpBlank()
    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        txtAge.text = ""
//        txtAge.becomeFirstResponder()
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblAge.font = UIFont.Poppins.medium.size(FontSize.body_13)
        txtAge.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
        lblSubmit.font = UIFont.Poppins.medium.size(FontSize.body_17)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
