//
//  FavouriteModulesViewController.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 24/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class FavouriteModulesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNoData: UILabel!
    
    // MARK: - Variables
    var favModuleViewModel = FavouriteModuleViewModel()
    var lessonsViewModel = EducationLessonViewModel()
    var favourites: [FavouriteModule] = []
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(nibWithCellClass: ReccommededCell.self, at: nil)
        lblNoData.setUp(title: "No Favourite Modules", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .AppColors.darkTextColor, noOfLine: 1)
        lblNoData.isHidden = true
        getFavouriteLessons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTitle("Favourite Module".localized(), isBackButton: true)
    }
    
    // MARK: - Private methods
    private func getFavouriteLessons() {
        ProgressHUD.show()
        favModuleViewModel.getFavouriteLessons {[weak self] isSuccess, error in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                  
                    self?.tableView.reloadData()
                } else {
                    self?.showErrorToast(error)
                    self?.alertMessage(title: error ?? "Oops!Something went wrong")
                    
                }
                self?.lblNoData.isHidden = !(self?.favModuleViewModel.arrFavouriteLessons.isEmpty ?? true)
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
                    self.getFavouriteLessons()
                    self.showSuccessToast("Removed from favourite")
                } else {
                    self.showErrorToast(error)
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
    
    // MARK: - Cell actions
    @IBAction func onBtnFavouriteTap(sender: UIButton) {
        let favouriteModule = self.favModuleViewModel.arrFavouriteLessons[sender.tag]
        if let object = favouriteModule.educationLesson, let lessonId = object.id {
            self.removeFavouriteLesson(lessonId: lessonId)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FavouriteModulesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favModuleViewModel.arrFavouriteLessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ReccommededCell.self)
        cell.selectionStyle = .none
        cell.imgCompleted.isHidden = true
        cell.progressLesson.isHidden = true
        cell.objFavouriteModule = self.favModuleViewModel.arrFavouriteLessons[indexPath.row]
        cell.btnFavourite.tag = indexPath.row
        cell.btnFavourite.addTarget(self, action: #selector(onBtnFavouriteTap(sender:)), for: .touchUpInside)
        return cell
    }
}
