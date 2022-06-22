//
//  ReflectionExpandableViewController.swift
//  Glow
//
//  Created by apple on 26/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class ReflectionExpandableViewController: UIViewController {
    
    static let identifier = "ReflectionExpandableViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var expandableTable: UITableView!
    
    @IBOutlet weak var displyLabel: UILabel!
    // MARK: - Variables
    var reflectionViewModel = ReflectionJournalViewModel()
    var arrReflectionJournal = [ReflectionJournal]()
    var expandedSection = [Bool]()
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        displyLabel.setUp(title: "No Journals", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .AppColors.darkTextColor, noOfLine: 1)
        displyLabel.isHidden = true
        expandableTable.delegate = self
        expandableTable.dataSource = self
        expandableTable.separatorStyle = .none
        if #available(iOS 15.0, *) {
            expandableTable.sectionHeaderTopPadding = 0
        }
        expandableTable.register(headerFooterViewClassWith: ExpandableSectionView.self)
        getReflectionJournal()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTitle("Reflection Journal".localized(), isBackButton: true)
    }
    
    // MARK: - Private methods
    private func getReflectionJournal() {
        
        ProgressHUD.show()
        reflectionViewModel.getReflectionJournal { isSuccess, error, arrReflectionJournals in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if let error = error {
                   // self.showErrorToast(error)
                    self.alertMessage(title: error)
                } else {
                    self.arrReflectionJournal = arrReflectionJournals ?? []
                    self.expandedSection = self.arrReflectionJournal.map({ _ in return false })
                    self.expandableTable.reloadData()
                }
             
                if self.reflectionViewModel.arrReflection.isEmpty ?? true {
                    self.displyLabel.isHidden = false
                    
                } else {
                    self.displyLabel.isHidden = true
                }
            }
        }
        
    }
    func alertMessage(title:String) {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        let alertVC = sb.instantiateViewController(identifier: "CustomAlertViewController") as! CustomAlertViewController
        alertVC.message = title
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.modalTransitionStyle = .crossDissolve
       // present(vc, animated: true, completion: nil)
        present(alertVC, animated: false, completion: nil)
        
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ReflectionExpandableViewController: UITableViewDataSource, UITableViewDelegate, ExpandableSectionDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrReflectionJournal.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withClass: ExpandableSectionView.self)
        headerView.section = section
        headerView.isExpanded = self.expandedSection[section]
        headerView.delegate = self
        headerView.lblTitle.text = self.arrReflectionJournal[section].name ?? ""
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.expandedSection[section] {
            return self.arrReflectionJournal[section].units?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withClass: ReflectionTableViewCell.self, for: indexPath)
        tableCell.selectionStyle = .none
        let arrUnit = self.arrReflectionJournal[indexPath.section].units ?? []
        tableCell.isLast = indexPath.row == arrUnit.count - 1
        tableCell.object = arrUnit[indexPath.row]
        return tableCell
    }
    
    func onHeaderTap(section: Int, isExpanded: Bool) {
        self.expandedSection[section] = isExpanded
        self.expandableTable.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}
