//
//  genderSelectCell.swift
//  Glow
//
//  Created by Cognitiveclouds on 07/06/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class genderSelectCell: UITableViewCell {

    @IBOutlet weak var maleLabel: UILabel!
    
    @IBOutlet weak var femalelabel: UILabel!
    
    @IBOutlet weak var othersLabel: UILabel!
    
    @IBOutlet weak var maleView: UIView!
    
    @IBOutlet weak var maleButton: UIButton!
    
    @IBOutlet weak var femaleView: UIView!
    
    @IBOutlet weak var femaleButton: UIButton!
    
    @IBOutlet weak var othersView: UIView!
    @IBOutlet weak var othersButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        maleLabel.setUp(title: "Male".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, noOfLine: 0)
        femalelabel.setUp(title: "Female".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, noOfLine: 0)
        othersLabel.setUp(title: "Others".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, noOfLine: 0)
        
       
        
        maleView.backgroundColor = UIColor.AppColors.themeColor
        maleView.layer.cornerRadius = Constant.buttonRadius
        maleView.clipsToBounds = true
        maleView.isUserInteractionEnabled = true
      
        femaleView.backgroundColor = UIColor.AppColors.themeColor
        femaleView.layer.cornerRadius = Constant.buttonRadius
        femaleView.clipsToBounds = true
        femaleView.isUserInteractionEnabled = true
        othersView.backgroundColor = UIColor.AppColors.themeColor
        othersView.layer.cornerRadius = Constant.buttonRadius
        othersView.clipsToBounds = true
        othersView.isUserInteractionEnabled = true
        maleButton.setUpBlank()
        femaleButton.setUpBlank()
        othersButton.setUpBlank()
        
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        maleLabel.font = UIFont.Poppins.medium.size(FontSize.body_17)
        femalelabel.font = UIFont.Poppins.medium.size(FontSize.body_17)
        othersLabel.font = UIFont.Poppins.medium.size(FontSize.body_17)
        
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
