//
//  RecentSearchCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 14/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class RecentSearchCell: UITableViewCell {
    
    static let identifier = "RecentSearchCell"
    
    // MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgDelete: UIImageView!
    @IBOutlet weak var btnDelete: UIButton!
    
    var objSearch: Search? {
        didSet {
            self.lblTitle.text = objSearch?.keyword ?? ""
        }
    }
    
    var objSearchResult: SearchResult? {
        didSet {
            self.lblTitle.text = objSearchResult?.name ?? ""
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblTitle.setUp(title: "", font: UIFont.Poppins.regular.size(FontSize.body_15), textColor: UIColor.AppColors.darkTextColor, noOfLine: 1)
        self.btnDelete.setUpBlank()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
