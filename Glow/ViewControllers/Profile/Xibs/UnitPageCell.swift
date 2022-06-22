//
//  UnitPageCell.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 25/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class UnitPageCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblTitle: UILabel!

    var isLast: Bool = false {
        didSet {
//            if isLast {
//                vwContainer.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//                vwContainer.layer.cornerRadius = Constant.viewRadius8
//                vwContainer.clipsToBounds = true
//            } else {
//                vwContainer.layer.maskedCorners = []
//            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.vwContainer.layer.cornerRadius = Constant.viewRadius8
        self.vwContainer.layer.borderWidth = Constant.viewBorder1
        self.vwContainer.layer.borderColor = UIColor.AppColors.borderColor_D8E1E5.cgColor
        self.vwContainer.clipsToBounds = true
        
//        vwContainer.layer.borderWidth = Constant.viewBorder1
//        vwContainer.layer.borderColor = UIColor.AppColors.borderColor_D8E1E5.cgColor
        
        lblTitle.setUp(title: "Page 1", font: UIFont.Poppins.regular.size(FontSize.body_14), textColor: UIColor.AppColors.grayTextColor, noOfLine: 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
