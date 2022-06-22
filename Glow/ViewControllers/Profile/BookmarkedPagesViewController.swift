//
//  BookmarkedPagesViewController.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 25/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class BookmarkedPagesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var displayLabel: UILabel!
    // MARK: - Variables
    var expandedSection = [Bool]()
    var expandedRow = [(section: Int, row: Int, isExpanded: Bool)]()
    var bookmarkViewModel = BookmarkViewModel()
    var arrBookmarks = [Bookmark]() //[(BookmarkEducationLesson?, [BookmarkEducationLessonPage?])]()
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        displayLabel.setUp(title: "No Bookmarks", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .AppColors.darkTextColor, noOfLine: 1)
        displayLabel.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.register(headerFooterViewClassWith: ExpandableSectionView.self)
        tableView.register(nib: UINib(nibName: "BookmarkModuleCell", bundle: nil), withCellClass: BookmarkModuleCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTitle("Bookmarked pages".localized(), isBackButton: true)
        self.getBookmarkList()
    }
    
    // MARK: - API Call
    private func getBookmarkList() {
        ProgressHUD.show()
        bookmarkViewModel.getBookmarkList { isSuccess, error, arrBookmark in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
//                for object in arrBookmark ?? [] {
//                    let recordFirstIndex = self.arrBookmarks.firstIndex { objectTuple in
//                        objectTuple.0?.id == object.educationLessonId
//                    }
//                    if let index = recordFirstIndex {
//                        self.arrBookmarks[index].1.append(object.educationLessonPage)
//                    } else {
//                        self.arrBookmarks.append((object.educationLesson, [object.educationLessonPage]))
//                    }
//                }
                if isSuccess {
                    self.arrBookmarks = arrBookmark ?? [Bookmark]()
                    self.expandedSection = self.arrBookmarks.map({ _ in return false })
                    for (sec, objBookmark) in self.arrBookmarks.enumerated() {
                        for (row, object) in (objBookmark.educationLessonUnits ?? []).enumerated() {
                            self.expandedRow.append((sec, row, false))
                        }
                    }
                    self.tableView.reloadData()
                }
                else {
                    self.showErrorToast(error)
                   // self.alertMessage(title: error ?? "Oops!Something went wrong")
                }
                if self.bookmarkViewModel.bookmarkPages.isEmpty ?? true {
                    self.displayLabel.isHidden = false
                    
                } else {
                    self.displayLabel.isHidden = true
                }
               
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension BookmarkedPagesViewController: UITableViewDelegate, UITableViewDataSource, ExpandableSectionDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrBookmarks.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withClass: ExpandableSectionView.self)
        headerView.section = section
        headerView.isExpanded = self.expandedSection[section]
        headerView.delegate = self
        headerView.lblTitle.text = self.arrBookmarks[section].name ?? ""
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.expandedSection[section] {
            return self.arrBookmarks[section].educationLessonUnits?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withClass: UnitPageCell.self, for: indexPath)
        let cell = tableView.dequeueReusableCell(withClass: BookmarkModuleCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.arrData = self.arrBookmarks[indexPath.section].educationLessonUnits ?? []
//        cell.lblTitle.text = self.arrBookmarks[indexPath.row].name ?? ""
//        cell.isExpanded = self.expandedSection[indexPath.row]
        
//        //let arrPages = self.arrBookmarks[indexPath.section].1 ?? []
//        let arrPages = self.arrBookmarks[indexPath.section].educationLessonUnits ?? []
//        cell.lblTitle.text = arrPages[indexPath.row].title
//        cell.isLast = indexPath.row == arrPages.count - 1
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.expandedSection[indexPath.row] = !self.expandedSection[indexPath.row]
//        self.tableView.reloadRows(at: [indexPath], with: .automatic)
//    }
    
    func onHeaderTap(section: Int, isExpanded: Bool) {
        self.expandedSection[section] = isExpanded
        self.tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}
