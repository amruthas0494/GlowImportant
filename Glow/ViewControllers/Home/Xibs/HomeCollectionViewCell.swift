//
//  HomeCollectionViewCell.swift
//  Glow
//
//  Created by Nidhishree HP on 21/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tileImage:UIImageView!
    @IBOutlet weak var tileTiles:UILabel!
    @IBOutlet weak var tileTopicsCount:UILabel!
    @IBOutlet weak var tilebackground:UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.AppColors.borderColor.cgColor
        self.contentView.layer.masksToBounds = true
        
        tileTiles.setUp(title: "", font: UIFont.Poppins.semiBold.size(FontSize.body_15), textColor: .white, noOfLine: 0)
        tileTopicsCount.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.subtitle_11), textColor: .white, noOfLine: 0)

        // Initialization code
    }

}
