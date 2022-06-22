//
//  NotificationListCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 07/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class NotificationListCell: UITableViewCell {
    
    static let identifier = "NotificationListCell"
    
    // MARK: - Outlets
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.AppColors.FCECFF
        self.selectedBackgroundView = backgroundView
        
        lblTitle.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor:UIColor .AppColors.themeColor, noOfLine: 0)
        lblDesc.setUp(title: "", font: UIFont.Poppins.regular.size(FontSize.subtitle_11), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        lblTime.setUp(title: "", font: UIFont.Poppins.regular.size(FontSize.subtitle_11), textColor: UIColor.AppColors.gray3, noOfLine: 1)
        
//        imgVw.layer.cornerRadius = imgVw.bounds.width/2
//        imgVw.clipsToBounds = true

        /*let backgroundView = UIView()
        backgroundView.backgroundColor = .AppColors.FCECFF
        self.selectedBackgroundView = backgroundView*/
        
        lblTitle.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.themeColor, noOfLine: 0)
        lblDesc.setUp(title: "", font: UIFont.Poppins.regular.size(FontSize.subtitle_11), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        lblTime.setUp(title: "", font: UIFont.Poppins.regular.size(FontSize.subtitle_11), textColor: UIColor.AppColors.gray3, noOfLine: 1)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgVw.layer.cornerRadius = UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20
        imgVw.clipsToBounds = true
    }

}
