//
//  ReflectionTableViewCell.swift
//  Glow
//
//  Created by apple on 26/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class ReflectionTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var viewDisplay: UIView!
    @IBOutlet weak var unitlabel: UILabel!
    @IBOutlet weak var lessonlabel: UILabel!
    @IBOutlet weak var summarylabel: UILabel!
    
    var isLast: Bool = false {
        didSet {
            if isLast {
                viewDisplay.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                viewDisplay.layer.cornerRadius = Constant.viewRadius8
                viewDisplay.clipsToBounds = true
            } else {
                viewDisplay.layer.maskedCorners = []
            }
        }
    }
    
    var object: ReflectionUnit? {
        didSet {
            unitlabel.text = object?.title ?? ""
            lessonlabel.text = object?.description ?? ""
            if let summary = object?.journal?.value, !summary.trimWhiteSpace.isEmpty {
                summarylabel.setUp(title: summary, font: UIFont.Poppins.regular.size(FontSize.body_15), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
            } else {
                summarylabel.setUp(title: "No entries", font: UIFont.Poppins.regular.size(FontSize.body_15), textColor: UIColor.AppColors.grey4, noOfLine: 0)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setUp()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setUp() {
        viewDisplay.layer.borderWidth = Constant.viewBorder1
        viewDisplay.layer.borderColor = UIColor.AppColors.borderColor_D8E1E5.cgColor
        unitlabel.setUp(title: "", font: UIFont.Poppins.regular.size(FontSize.subtitle_11), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
        lessonlabel.setUp(title: "", font: UIFont.Poppins.bold.size(FontSize.body_15), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        summarylabel.setUp(title: "", font: UIFont.Poppins.regular.size(FontSize.body_15), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        
    }
    
}
