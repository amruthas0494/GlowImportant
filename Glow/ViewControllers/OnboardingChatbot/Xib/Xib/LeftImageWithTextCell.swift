//
//  LeftImageWithTextCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 24/11/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class LeftImageWithTextCell: UITableViewCell {
    
    static let identifier = "LeftImageWithTextCell"
    
    // MARK: - Outlets
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var lblTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblText.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.blackText, noOfLine: 0)
        lblTime.setUp(title: "", font: UIFont.Poppins.regular.size(FontSize.subtitle_11), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
        
        self.imgView.layer.cornerRadius = self.imgView.frame.width/2
        self.imgView.clipsToBounds = true
        
        self.vwContainer.backgroundColor = UIColor.AppColors.navigationBackground
        self.vwContainer.layer.borderWidth = Constant.viewBorder
        self.vwContainer.layer.borderColor = UIColor.AppColors.border_Color.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblText.font = UIFont.Poppins.medium.size(FontSize.body_17)
        lblTime.font = UIFont.Poppins.regular.size(FontSize.subtitle_11)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.vwContainer.bounds, byRoundingCorners: [.topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: Constant.viewRadius16, height: Constant.viewRadius16))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.vwContainer.layer.mask = mask
        }
    }
}
