//
//  RightImageCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 06/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class RightImageCell: UITableViewCell {
    
    static let identifier = "RightImageCell"
    
    // MARK: - outlets
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var lblTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblTime.setUp(title: "".Chatbotlocalized(), font: UIFont.Poppins.regular.size(FontSize.subtitle_11),
                      textColor: .white, noOfLine: 1)
        
        imgVw.layer.cornerRadius = Constant.viewRadius16
        imgVw.clipsToBounds = true
        
        vwContainer.backgroundColor = UIColor.AppColors.themeColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblTime.font = UIFont.Poppins.regular.size(FontSize.subtitle_11)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.vwContainer.bounds, byRoundingCorners: [.topLeft, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: Constant.viewRadius16, height: Constant.viewRadius16))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.vwContainer.layer.mask = mask
        }
    }
    
}
