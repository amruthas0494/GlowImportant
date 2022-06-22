//
//  FACQuestionCell.swift
//  Glow
//
//  Created by Cognitiveclouds on 17/05/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class FACQuestionCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    
    
    @IBOutlet weak var DropimageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.questionLabel.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: UIColor.AppColors.blackText, noOfLine: 0)
        //populate(with: ExpandedSection)
    }
    func populate(with data: ExpandedSection) {
       
        questionLabel.text = data.headingTitle
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
