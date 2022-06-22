//
//  TextNumberInputCell.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 04/03/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class TextNumberInputCell: UITableViewCell {

    // MARK: - Outlet
    @IBOutlet weak var txtInput: UITextField!
    @IBOutlet weak var vwSubmit: UIView!
    @IBOutlet weak var lblSubmit: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var isNumber: Bool = false {
        didSet {
            if isNumber {
                txtInput.keyboardType = .numberPad
            } else {
                txtInput.keyboardType = .default
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
                    
        txtInput.text = ""
        txtInput.backgroundColor = .AppColors.navigationBackground
        txtInput.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
    
        vwSubmit.backgroundColor = .AppColors.themeColor
        vwSubmit.layer.cornerRadius = Constant.buttonRadius
        vwSubmit.clipsToBounds = true
        
        lblSubmit.setUp(title: "Submit", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, noOfLine: 1)
        btnSubmit.setUpBlank()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
