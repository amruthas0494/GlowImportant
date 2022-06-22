//
//  ReccommendedViewController.swift
//  Glow
//
//  Created by Nidhishree HP on 21/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit
import ProgressHUD

class ReccommendedViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNoData: UILabel!
    
    // MARK: - Variable
    var lessonsViewModel = EducationLessonViewModel()
    var displayData:String = ""
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(nibWithCellClass: ReccommededCell.self, at: nil)
        tableView.register(nib: UINib(nibName: ReccommededHeaderView.identifier, bundle: nil), withHeaderFooterViewClass: ReccommededHeaderView.self)
        tableView.separatorStyle = .none
        if #available(iOS 15.0, *) {
             tableView.sectionHeaderTopPadding = 0.0
        }
        lblNoData.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .AppColors.darkTextColor, noOfLine: 1)
        lblNoData.isHidden = true
        
        getLessonListForCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTitle("", isBackButton: true)
    }
    
    // MARK: - get lesson list of category
    private func getLessonListForCategory() {
        
        ProgressHUD.show()
        lessonsViewModel.getEducationLessonListForCategory { isSuccess, error in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                    self.tableView.reloadData()
                } else {
                    self.showErrorToast(error)
                    self.alertMessage(title: error ?? "Oops!Something went wrong")
                }
                if self.lessonsViewModel.lessonListForCategory?.educationLessons?.isEmpty ?? true {
                    self.lblNoData.isHidden = false
                    self.lblNoData.text = self.displayData
                } else {
                    self.lblNoData.isHidden = true
                }
            }
        }
    }
    
    private func favouriteLesson(lessonId: String?) {
        guard let lessonId = lessonId else {
            return
        }
        ProgressHUD.show()
        lessonsViewModel.lessonId = lessonId
        lessonsViewModel.addLessonToFavourites { isSuccess, error in
            DispatchQueue.main.async {
                if isSuccess {
                self.showSuccessToast("Added to favourite")
                self.getLessonListForCategory()
                } else {
                    self.showErrorToast(error)
                }
            }
        }
    }
    
    private func removeFavouriteLesson(lessonId: String?) {
        guard let lessonId = lessonId else {
            return
        }
        ProgressHUD.show()
        lessonsViewModel.lessonId = lessonId
        lessonsViewModel.removeLessonFromFavourite { isSuccess, error in
            DispatchQueue.main.async {
                if isSuccess {
                    self.getLessonListForCategory()
                    self.showSuccessToast("Removed from favourite")
                } else {
                    self.showErrorToast(error)
                }
            }
        }
    }
    
    // MARK: - Cell actions
    @IBAction func onBtnFavouriteTap(sender: UIButton) {
        if let educationCategory = self.lessonsViewModel.lessonListForCategory,
           let lessons = educationCategory.educationLessons {
            let object = lessons[sender.tag]
            if (object.favourites ?? []).isEmpty {
                favouriteLesson(lessonId: object.id)
            } else {
                removeFavouriteLesson(lessonId: object.id)
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

extension ReccommendedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vwHeader = tableView.dequeueReusableHeaderFooterView(withClass: ReccommededHeaderView.self)
        vwHeader.lblTitle.setUp(title: "", font: UIFont.Poppins.semiBold.size(FontSize.body_17), textColor: UIColor.AppColors.darkTextColor, noOfLine: 1)
        vwHeader.lblSubtitle.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.subtitle_11), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
        vwHeader.lblTitle.text = self.lessonsViewModel.lessonListForCategory?.name
        vwHeader.lblSubtitle.text = self.lessonsViewModel.lessonListForCategory?.description
        return vwHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lessonsViewModel.lessonListForCategory?.educationLessons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ReccommededCell.self)
        cell.selectionStyle = .none
        if let educationCategory = self.lessonsViewModel.lessonListForCategory,
           let lessons = educationCategory.educationLessons {
            let object = lessons[indexPath.row]
            cell.objLesson = object
        }
        cell.btnFavourite.tag = indexPath.row
        cell.btnFavourite.addTarget(self, action: #selector(onBtnFavouriteTap(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let educationCategory = self.lessonsViewModel.lessonListForCategory,
           let lessons = educationCategory.educationLessons {
            let topicsVC = TopicsViewController.instantiateFromAppStoryBoard(appStoryBoard: .topics)
            topicsVC.hidesBottomBarWhenPushed = true
            topicsVC.lesson = lessons[indexPath.row]
            self.navigationController?.pushViewController(topicsVC, animated: true)
        }
    }
}
