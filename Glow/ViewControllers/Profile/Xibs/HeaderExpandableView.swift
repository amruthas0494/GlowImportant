//
//  HeaderExpandableView.swift
//  Glow
//
//  Created by Cognitiveclouds on 17/05/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit
protocol sectionExpandableDelegate {
    func toggleSection(header:HeaderExpandableView, section: Int)
}

class HeaderExpandableView: UITableViewHeaderFooterView {

   
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tapButton: UIButton!
    
    @IBOutlet weak var expandIamgeView: UIImageView!
     var delegate: sectionExpandableDelegate?
    var section: Int = 0
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderView)))
        self.titleLabel.setUp(title: "Diabetes and your feet", font: UIFont.Poppins.semiBold.size(FontSize.body_17), textColor: UIColor.AppColors.darkTextColor, noOfLine: 2)
        self.tapButton.setUpBlank()
    }
    
    func populate(with data: ExpandedSection) {
       
        titleLabel.text = data.headingTitle
       
    }

    @objc func selectHeaderView(gesture: UITapGestureRecognizer) {
        
        
        let cell = gesture.view as! ExpandableSectionView
        delegate?.toggleSection(header: self, section: cell.section)
    }
    @IBAction func expandButtonTapped(_ sender: UIButton) {
        if tapButton.isSelected {
            expandIamgeView.image = UIImage(named: "minus")
            tapButton.addTarget(self, action: #selector(selectHeaderView(gesture:)), for: .allEvents)
        }
        else {
            expandIamgeView.image = UIImage(named: "plus")
        }
       
    }
    
}
