//
//  SliderCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 29/11/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class SliderCell: UITableViewCell {
    
    static let identifier = "SliderCell"
    
    // MARK: - Outlets
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    
    var objSetting: StepSetting? {
        didSet {
            if let objSetting = objSetting {
                lblStart.text = "\(objSetting.minValue ?? 0)\n\(objSetting.leftLabel ?? "")"
                lblEnd.text = "\(objSetting.maxValue ?? 10)\n\(objSetting.rightLabel ?? "")"
                slider.minimumValue = Float(objSetting.minValue ?? 0)
                slider.maximumValue = Float(objSetting.maxValue ?? 10)
                slider.setValue(Float(objSetting.defaultValue ?? 0), animated: true)
            }
        }
    }
    
    var action: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.thumbTintColor = .AppColors.themeColor
        slider.tintColor = .AppColors.themeColor
        slider.isContinuous = false
        
        lblStart.setUp(title: "0\nNot ready".Chatbotlocalized(), font: UIFont.Poppins.semiBold.size(FontSize.subtitle_12), textColor: UIColor.AppColors.darkTextColor, noOfLine: 2)
        lblStart.textAlignment = .center
        lblEnd.setUp(title: "10\nvery ready".Chatbotlocalized(), font: UIFont.Poppins.semiBold.size(FontSize.subtitle_12), textColor: UIColor.AppColors.grayTextColor, noOfLine: 2)
        lblEnd.textAlignment = .center
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblStart.font = UIFont.Poppins.semiBold.size(FontSize.subtitle_12)
        lblEnd.font = UIFont.Poppins.semiBold.size(FontSize.subtitle_12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
