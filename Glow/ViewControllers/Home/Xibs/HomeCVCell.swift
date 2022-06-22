//
//  HomeCVCell.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 27/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class HomeCVCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imgVwIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var object: (id: Int, image: String, color: UIColor, title: String)? {
        didSet {
            vwContainer.backgroundColor = object?.color
            if let imageIs = object?.image {
                imgVwIcon.image = UIImage(named: imageIs)
            }
            lblTitle.text = object?.title.localized()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.vwContainer.layer.cornerRadius = Constant.viewRadius8
        self.vwContainer.clipsToBounds = true
        self.lblTitle.setUp(title: "", font: UIFont.Poppins.semiBold.size(FontSize.body_15), textColor: .white, noOfLine: 0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblTitle.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
    }
}
