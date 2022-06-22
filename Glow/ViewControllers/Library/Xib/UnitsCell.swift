//
//  UnitsCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 22/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class UnitsCell: UITableViewCell {
    
    static let identifier = "UnitsCell"
    
    // MARK: - Outlets
    @IBOutlet weak var lblUnit: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    var objUnit: Unit? {
        didSet {
            lblUnit.text = objUnit?.title ?? ""
            lblName.text = objUnit?.description ?? ""
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        lblUnit.setUp(title: "", font: UIFont.Poppins.semiBold.size(FontSize.body_17), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
        lblName.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: UIColor.AppColors.darkTextColor, noOfLine: 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
