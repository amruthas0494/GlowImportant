//
//  ExpandableSectionView.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 25/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

protocol ExpandableSectionDelegate: AnyObject {
    func onHeaderTap(section: Int, isExpanded: Bool)
}

class ExpandableSectionView: UITableViewHeaderFooterView {
    
    // MARK: - Outlets
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgDropdown: UIImageView!
    @IBOutlet weak var btnHeader: UIButton!
    
    weak var delegate: ExpandableSectionDelegate?
    var section: Int = 0
    var isExpanded: Bool = false {
        didSet {
            if isExpanded {
                self.imgDropdown.image = UIImage(named: "minus")
//                self.vwContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//                self.imgDropdown.transform = imgDropdown.transform.rotated(by: .pi)
            } else {
                self.imgDropdown.image = UIImage(named: "plus")
//                self.vwContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
//            self.vwContainer.layer.cornerRadius = Constant.viewRadius8
//            self.vwContainer.clipsToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.vwContainer.layer.cornerRadius = Constant.viewRadius8
//        self.vwContainer.layer.borderWidth = Constant.viewBorder1
//        self.vwContainer.layer.borderColor = UIColor.AppColors.borderColor_D8E1E5.cgColor
//        self.vwContainer.clipsToBounds = true
        
        self.lblTitle.setUp(title: "Diabetes and your feet".localized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.darkTextColor, noOfLine: 2)
        self.btnHeader.setUpBlank()
    }
    
    @IBAction func onBtnHeaderTap(sender: UIButton) {
        let isExpanded = !self.isExpanded
        self.delegate?.onHeaderTap(section: self.section, isExpanded: isExpanded)
    }
}
