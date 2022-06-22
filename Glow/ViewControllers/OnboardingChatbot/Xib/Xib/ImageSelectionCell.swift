//
//  ImageSelectionCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 06/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class ImageSelectionCell: UITableViewCell {
    
    static let identifier = "ImageSelectionCell"
    
    // MARK: - Outlet
    @IBOutlet weak var imgVwOne: UIImageView!
    @IBOutlet weak var imgRadioOne: UIImageView!
    @IBOutlet weak var btnOne: UIButton!
    @IBOutlet weak var imgVwTwo: UIImageView!
    @IBOutlet weak var imgRadioTwo: UIImageView!
    @IBOutlet weak var btnTwo: UIButton!

    var selectedOption: Int = 1 {
        didSet {
            if selectedOption == 1 {
                [imgVwOne, imgVwTwo].forEach { img in
                    img?.layer.borderWidth = img == imgVwOne ? 2 : 0
                    img?.layer.borderColor = img == imgVwOne ? UIColor.AppColors.themeColor.cgColor : UIColor.clear.cgColor
                }
                [imgRadioOne, imgRadioTwo].forEach { img in
                    img?.image = img == imgRadioOne ? UIImage(named: "radioSelected") : UIImage(named: "radio")
                }
            } else {
                [imgVwOne, imgVwTwo].forEach { img in
                    img?.layer.borderWidth = img == imgVwTwo ? 2 : 0
                    img?.layer.borderColor = img == imgVwTwo ? UIColor.AppColors.themeColor.cgColor : UIColor.clear.cgColor
                }
                [imgRadioOne, imgRadioTwo].forEach { img in
                    img?.image = img == imgRadioTwo ? UIImage(named: "radioSelected") : UIImage(named: "radio")
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        [imgVwOne, imgVwTwo].forEach { img in
            img?.layer.cornerRadius = Constant.viewRadius23
            img?.clipsToBounds = true
        }
        [btnOne, btnTwo].forEach { btn in
            btn?.setUpBlank()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
