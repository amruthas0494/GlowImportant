//
//  BookmarkModuleCell.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 17/05/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class BookmarkModuleCell: UITableViewCell {
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nslcTableHeight: NSLayoutConstraint!
    
    var arrData = [BookmarkEducationLessonUnit]()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(headerFooterViewClassWith: ExpandableSectionView.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.nslcTableHeight.constant = self.tableView.contentSize.height
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension BookmarkModuleCell: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withClass: ExpandableSectionView.self)
        headerView.section = section
//        headerView.isExpanded = self.expandedSection[section]
//        headerView.delegate = self
        headerView.lblTitle.text = self.arrData[section].title ?? ""
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
