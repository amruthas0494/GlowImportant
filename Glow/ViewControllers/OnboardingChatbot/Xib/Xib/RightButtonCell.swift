//
//  RightButtonCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 23/11/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class RightButtonCell: UITableViewCell {
    
    static let identifier = "RightButtonCell"
    
    // MARK: - Outlets
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnOption: UIButton!
    
    var action: String?

    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        vwContainer.backgroundColor = UIColor.AppColors.themeColor
        vwContainer.layer.cornerRadius = Constant.viewRadius8
        vwContainer.clipsToBounds = true
        
        lblTitle.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_17),
                       textColor: .white, noOfLine: 0)
        btnOption.setUpBlank()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblTitle.font = UIFont.Poppins.medium.size(FontSize.body_17)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpButtonFontSize(size: CGFloat) {
        lblTitle.font = UIFont.Poppins.medium.size(size)
    }
    
}
