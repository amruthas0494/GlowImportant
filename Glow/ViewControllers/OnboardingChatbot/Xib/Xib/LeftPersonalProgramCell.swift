//
//  LeftPersonalProgramCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 29/11/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class LeftPersonalProgramCell: UITableViewCell {
    
    static let identifier = "LeftPersonalProgramCell"

    // MARK: - Outlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblPercentage: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var lblProgram: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblPercentage.setUp(title: "", font: UIFont.Poppins.semiBold.size(FontSize.title1_23), textColor: UIColor.AppColors.blackText, noOfLine: 1)
        progress.progress = 0.87
        progress.tintColor = UIColor.AppColors.themeColor
        progress.trackTintColor = UIColor.gray
        lblProgram.setUp(title: "Creating your personal program".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        lblTime.setUp(title: "", font: UIFont.Poppins.regular.size(FontSize.subtitle_12), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
        
        self.imgView.layer.cornerRadius = self.imgView.frame.width/2
        self.imgView.clipsToBounds = true
        
        self.vwContainer.layer.borderWidth = Constant.viewBorder
        self.vwContainer.layer.borderColor = UIColor.AppColors.border_Color.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblPercentage.font = UIFont.Poppins.semiBold.size(FontSize.title1_23)
        lblProgram.font = UIFont.Poppins.medium.size(FontSize.body_17)
        lblTime.font = UIFont.Poppins.regular.size(FontSize.subtitle_12)
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
