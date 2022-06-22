//
//  MCQCell.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 04/03/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

protocol MCQDelegate: AnyObject {
    func onObjectSelection(object: StepOption?)
    func onFAQObjSelect(object:Options?)
}

class MCQCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var tblOption: UITableView!
    @IBOutlet weak var nslcTblHeight: NSLayoutConstraint!
   // var  parameterTuple = ([StepOption]?, [Options]?)
    var arrOptions: [StepOption]?
   // var faqOptions: [Options]?
    
    weak var delegate: MCQDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.tblOption.delegate = self
        self.tblOption.dataSource = self
        self.tblOption.register(nibWithCellClass: MCQOptionCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.nslcTblHeight.constant = self.tblOption.contentSize.height
        }
    }
    
    @IBAction func onBtnOptionClick(sender: UIButton) {
        if let arrOptions = arrOptions {
            let option = arrOptions[sender.tag]
            self.delegate?.onObjectSelection(object: option)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MCQCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.arrOptions ?? []).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = self.arrOptions?[indexPath.item]
        let cell = tableView.dequeueReusableCell(withClass: MCQOptionCell.self)
        cell.objOption = object
        //cell.objOption.setText(value: <#T##String?#>, highlight: <#T##String?#>)
        cell.btnOption.tag = indexPath.row
        cell.btnOption.addTarget(self, action: #selector(onBtnOptionClick(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.nslcTblHeight.constant = self.tblOption.contentSize.height
        self.layoutSubviews()
    }
}
