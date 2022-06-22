//
//  GenderSelectionCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 30/11/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class GenderSelectionCell: UITableViewCell {
    
    static let identifier = "GenderSelectionCell"
    
    // MARK: - Outlet
    @IBOutlet weak var vwMale: UIView!
    @IBOutlet weak var imgMale: UIImageView!
    @IBOutlet weak var lblMale: UILabel!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var vwFemale: UIView!
    @IBOutlet weak var imgFemale: UIImageView!
    @IBOutlet weak var lblFemale: UILabel!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var vwOther: UIView!
    @IBOutlet weak var imgOther: UIImageView!
    @IBOutlet weak var lblOther: UILabel!
    @IBOutlet weak var btnOther: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        [vwMale, vwFemale, vwOther].forEach { vw in
            vw?.backgroundColor = UIColor.AppColors.navigationBackground
            vw?.layer.cornerRadius = Constant.viewRadius16
            vw?.clipsToBounds = true
            vw?.layer.borderWidth = Constant.viewBorder
            vw?.layer.borderColor = UIColor.AppColors.borderColor.cgColor
        }
        [imgMale, imgFemale, imgOther].forEach { img in
            img?.tintColor = UIColor.AppColors.borderColor
        }
        [lblMale, lblFemale, lblOther].forEach { lbl in
            lbl?.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
        }
        [btnMale, btnFemale, btnOther].forEach { btn in
            btn?.setUpBlank()
        }
        lblMale.text = "Male".Chatbotlocalized()
        lblFemale.text = "Female".Chatbotlocalized()
        lblOther.text = "Others".Chatbotlocalized()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        [lblMale, lblFemale, lblOther].forEach { lbl in
            lbl?.font = UIFont.Poppins.medium.size(FontSize.body_15)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func selectGender(sender: UIButton) {
        
        let vwSelected = sender == btnMale ? vwMale : sender == btnFemale ? vwFemale : vwOther
        [vwMale, vwFemale, vwOther].forEach { vw in
            vw?.layer.borderColor = vwSelected == vw ? UIColor.AppColors.themeColor.cgColor : UIColor.AppColors.borderColor.cgColor
        }
        let lblSelected = sender == btnMale ? lblMale : sender == btnFemale ? lblFemale : lblOther
        [lblMale, lblFemale, lblOther].forEach { lbl in
            lbl?.textColor = lbl == lblSelected ? UIColor.AppColors.themeColor : UIColor.AppColors.grayTextColor
        }
        let imgSelected = sender == btnMale ? imgMale : sender == btnFemale ? imgFemale : imgOther
        [imgMale, imgFemale, imgOther].forEach { img in
            img?.tintColor = img == imgSelected ? UIColor.AppColors.themeColor : UIColor.AppColors.borderColor
        }
    }
}
