//
//  YesNoCell.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 04/03/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class YesNoCell: UITableViewCell {
    
    // MARK: - Outlet
    @IBOutlet weak var vwYes: UIView!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var vwNo: UIView!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var btnNo: UIButton!
    
    var arrOptions: [StepOption]?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        [vwNo, vwYes].forEach { vw in
            vw?.backgroundColor = .AppColors.themeColor
            vw?.layer.cornerRadius = Constant.buttonRadius
            vw?.clipsToBounds = true
        }
        lblYes.setUp(title: "Yes", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: .white, noOfLine: 0)
        lblNo.setUp(title: "No", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: .white, noOfLine: 0)
        [btnYes, btnNo].forEach { btn in
            btn?.setUpBlank()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
