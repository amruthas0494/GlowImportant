//
//  RightTextViewCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 22/11/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class RightTextViewCell: UITableViewCell {
    
    static let identifier = "RightTextViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var lblTime: UILabel!
        
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblText.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_17),
                      textColor: .white, noOfLine: 0)
        lblTime.setUp(title: "", font: UIFont.Poppins.regular.size(FontSize.subtitle_11),
                      textColor: .white, noOfLine: 1)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblText.font = UIFont.Poppins.medium.size(FontSize.body_17)
        lblTime.font = UIFont.Poppins.regular.size(FontSize.subtitle_11)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
