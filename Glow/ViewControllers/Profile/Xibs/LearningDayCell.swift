//
//  LearningDayCell.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 24/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class LearningDayCell: UICollectionViewCell {
    
    // MARK: - Outlet
    @IBOutlet weak var vwContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vwContainer.layer.cornerRadius = Constant.viewBorder
        vwContainer.clipsToBounds = true
    }
}
