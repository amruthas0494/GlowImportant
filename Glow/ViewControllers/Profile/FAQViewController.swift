//
//  FAQViewController.swift
//  Glow
//
//  Created by Cognitiveclouds on 17/05/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit
struct ExpandedSection {
    var id: String!
    var headingTitle:String!
    var expanded:Bool!
    init(id:String, headingTitle:String, expanded:Bool) {
        self.id = id
        self.headingTitle = headingTitle
        self.expanded = expanded
    }
}

class FAQViewController: UIViewController {

    @IBOutlet weak var FAQTableView: UITableView!
    static let identifier = "FAQViewController"
    // MARK: - Variables
    var expandedSection = [Bool]()
   
    var reflectionViewModel = ReflectionJournalViewModel()
    var arrReflectionJournal = [ReflectionJournal]()
    var sections = ["Basics of Diabetes", "Medication Management", "Talking to your Physican, Alernative medication and medication under special circumstances"]
    var expandSection1  = [ExpandedSection(id: "1", headingTitle: "Basics of Diabetes", expanded: false), ExpandedSection(id: "2", headingTitle: "Medication Management", expanded: false),ExpandedSection(id: "3", headingTitle: "Talking to your Physican, Alernative medication and medication under special circumstances", expanded: false)]
    
    var selectIndexPath:IndexPath!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTitle("FAQ's", isBackButton: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectIndexPath = IndexPath(row: -1, section: -1)

        // Do any additional setup after loading the view.
        FAQTableView.delegate = self
        FAQTableView.dataSource = self
        FAQTableView.separatorStyle = .none
        if #available(iOS 15.0, *) {
            FAQTableView.sectionHeaderTopPadding = 0
        }
        FAQTableView.register(nibWithCellClass: FACQuestionCell.self, at: nil)
        FAQTableView.register(headerFooterViewClassWith: HeaderExpandableView.self)
       // FAQTableView.register(headerFooterViewClassWith: ExpandableSectionView.self)
        //getReflectionJournal()
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
                    self.FAQTableView.reloadData()
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
    

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FAQViewController: UITableViewDelegate, UITableViewDataSource, ExpandableSectionDelegate, sectionExpandableDelegate {
   

    func numberOfSections(in tableView: UITableView) -> Int {
        return expandSection1.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    func viewForHeaderInSection(_ tableView: UITableView, section: Int) -> UIView?  {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderExpandableView") as! HeaderExpandableView
        
        headerView.populate(with: expandSection1[section])
        headerView.titleLabel.font = UIFont.Poppins.semiBold.size(FontSize.body_17)
        headerView.delegate = self
        //headerView.isExpanded = self.expandedSection[section]
      //  headerView.addTapGesture(target: self, action: #selector(handleExpandClose))
        headerView.tag = section
        return headerView
    }
    /*
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withClass: HeaderExpandableView.self)
        headerView.section = section
        headerView.isExpanded = self.expandedSection[section]
        headerView.delegate = self
        headerView.lblTitle.text = "Introduction to Diabetes"
        return headerView
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
        }
        let tableCell = tableView.dequeueReusableCell(withClass: FACQuestionCell.self, for: indexPath)
        tableCell.selectionStyle = .none
        
        return tableCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (expandSection1[indexPath.section].expanded) {
            return UITableView.automaticDimension
        }
        else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectIndexPath = indexPath
        self.expandSection1[indexPath.section].expanded = !expandSection1[indexPath.section].expanded
        tableView.beginUpdates()
        tableView.reloadSections([indexPath.section], with: .automatic)
        tableView.endUpdates()
    }
    func onHeaderTap(section: Int, isExpanded: Bool) {
        self.expandedSection[section] = isExpanded
        self.FAQTableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    func toggleSection(header: HeaderExpandableView, section: Int) {
        self.expandSection1[section].expanded = !expandSection1[section].expanded
        FAQTableView.beginUpdates()
        FAQTableView.reloadSections([section], with: .automatic)
        FAQTableView.endUpdates()
    }
    
    
    
}
