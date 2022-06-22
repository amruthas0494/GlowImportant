//
//  ProfileMenuCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 08/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class ProfileMenuCell: UITableViewCell {
    
    static let identifier = "ProfileMenuCell"
    
    // MARK: - Outlets
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.setUp(title: "", font: UIFont.Poppins.regular.size(FontSize.body_15), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
