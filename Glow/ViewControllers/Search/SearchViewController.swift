//
//  SearchViewController.swift
//  Glow
//
//  Created by Pushpa Yadav on 14/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    static let identifier = "SearchViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var vwSearch: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var NoResultsLabel: UILabel!
    // MARK: - Variables
    var searchViewModel = SearchViewModel()
    var searchTimer: Timer?
    var searchText: String!
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.register(nib: UINib(nibName: ReccommededHeaderView.identifier, bundle: nil), withHeaderFooterViewClass: ReccommededHeaderView.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTitle("Search")
        getRecentSearches()
    }
    
    // MARK: - Private methods
    private func decorateUI() {
        
        vwSearch.layer.cornerRadius = Constant.viewRadius4
        vwSearch.layer.borderWidth = Constant.viewBorder1
        vwSearch.layer.borderColor = UIColor.AppColors.searchBorder.cgColor
        vwSearch.backgroundColor = UIColor.AppColors.navigationBackground
        vwSearch.clipsToBounds = true
        NoResultsLabel.setUp(title: "No Results", font: UIFont.Poppins.semiBold.size(FontSize.body_17), textColor: UIColor.AppColors.blackText, noOfLine: 0)
        NoResultsLabel.isHidden = true
       
        txtSearch.placeholder = "Search for module, unit or more"
        txtSearch.font = UIFont.Poppins.medium.size(FontSize.body_15)
       
        txtSearch.textColor = UIColor.AppColors.gray3
        txtSearch.addTarget(self, action: #selector(searchFieldChange), for: .editingChanged)
        
    }
    
    private func getRecentSearches() {
        ProgressHUD.show()
        searchViewModel.getRecentSearches { isSuccess, error in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
//                    if self.searchViewModel.arrRecentSearch.isEmpty {
//                        self.NoResultsLabel.text = "No Results"
//                    }
//                    else {
//                        self.NoResultsLabel.text = " "
//                        self.tableView.reloadData()
//                    }
                    self.tableView.reloadData()
                   
                } else {
                   
                   // self.showErrorToast("No Results")
                    self.alertMessage(title: error ?? "Oops!Something went wrong")

                }
              
            }
        }
    }
    
    private func deleteRecentSearch(searchId: String) {
        ProgressHUD.show()
        searchViewModel.searchId = searchId
        searchViewModel.deleteRecentSearch { isSuccess, error in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                    self.getRecentSearches()
                } else {
                    //self.showErrorToast(error)
                    self.alertMessage(title: error ?? "Oops!Something went wrong")
                }
            }
        }
    }
    
    private func getSearchResult(keyword: String) {
        ProgressHUD.show()
        searchViewModel.keyword = keyword
        searchViewModel.getSearchResult { isSuccess, error in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                    if self.searchViewModel.arrSearchResult.isEmpty {
                        self.NoResultsLabel.isHidden = false
                    }
                    else {
                        self.NoResultsLabel.isHidden = true
                        self.tableView.reloadData()
                    }
                } else {
                   // self.showErrorToast(error)
                    self.alertMessage(title: error ?? "Oops!Something went wrong")
                }
            }
        }
    }
    
    private func cancelSearch() {
        self.searchViewModel.arrSearchResult = []
        self.tableView.reloadData()
    }
    
    // MARK: - Cell action
    @IBAction func onBtnDeleteTap(sender: UIButton) {
        let object = self.searchViewModel.arrRecentSearch[sender.tag]
        guard let searchId = object.id else {
            self.showErrorToast("Unable to find search id.".localized())
            return
        }
        deleteRecentSearch(searchId: searchId)
    }
    
    @objc func searchFieldChange(_ textField: UITextField) {
        if self.searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }
        self.searchTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchForKeyword), userInfo: textField.text, repeats: false)
    }
    
    @objc func searchForKeyword(_ timer: Timer) {
        searchText = timer.userInfo as? String ?? ""
        if searchText.isEmpty {
            self.cancelSearch()
        } else {
            //Cancel old search request
            searchViewModel.cancelAllSearch()
            //Call your api
            self.getSearchResult(keyword: searchText)
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = !searchViewModel.arrSearchResult.isEmpty ? "Search Result" : "Recent Searches"
        let vwHeader = tableView.dequeueReusableHeaderFooterView(withClass: ReccommededHeaderView.self)
        vwHeader.lblTitle.setUp(title: title.localized(), font: UIFont.Poppins.semiBold.size(FontSize.body_17), textColor: UIColor.AppColors.darkTextColor, noOfLine: 1)
        vwHeader.lblSubtitle.text = nil
        return vwHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == .pad ? 100 : 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !searchViewModel.arrSearchResult.isEmpty {
            return searchViewModel.arrSearchResult.count
        }
        return searchViewModel.arrRecentSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchCell.identifier) as! RecentSearchCell
        cell.selectionStyle = .none
        if !self.searchViewModel.arrSearchResult.isEmpty {
            cell.objSearchResult = self.searchViewModel.arrSearchResult[indexPath.row]
            cell.imgDelete.isHidden = true
            cell.btnDelete.isHidden = true
        } else {
            cell.objSearch = self.searchViewModel.arrRecentSearch[indexPath.row]
            cell.imgDelete.isHidden = false
            cell.btnDelete.isHidden = false
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(onBtnDeleteTap(sender:)), for: .touchUpInside)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !self.searchViewModel.arrSearchResult.isEmpty {
            if let lessonId = self.searchViewModel.arrSearchResult[indexPath.row].id {
                searchViewModel.createRecentSearch()
                let topicsVC = TopicsViewController.instantiateFromAppStoryBoard(appStoryBoard: .topics)
                topicsVC.hidesBottomBarWhenPushed = true
                topicsVC.lessonsViewModel.lessonId = lessonId
                self.navigationController?.pushViewController(topicsVC, animated: true)
            }
        } else {
            if let keyword = self.searchViewModel.arrRecentSearch[indexPath.row].keyword {
                self.txtSearch.text = keyword
                self.getSearchResult(keyword: keyword)
            }
        }
    }
}
