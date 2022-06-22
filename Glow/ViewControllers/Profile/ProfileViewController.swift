//
//  ProfileViewController.swift
//  Glow
//
//  Created by Pushpa Yadav on 08/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class ProfileViewController: UIViewController {
    
    static let identifier = "ProfileViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var nslcTableHeight: NSLayoutConstraint!
    
    let logOutViewModel = LogOutViewModel()

    
    // MARK: - Variables
    let arrMenu: [(id: Int, icon: String, title: String)] = [(1, "myActivities", "My activities"),
                                                             (2, "reflectionJournal", "Reflection journal"),
                                                             (3, "savedUnits", "Bookmarked pages"),
                                                             (4, "favouriteModules", "Favourite Modules"),
                                                             (5, "setting", "Settings")]
   // (5, "FAQ's", "FAQ"),
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.setTitle("Profile".localized(), isBackButton: true)
        self.decorateUI()
        if let imgUrl = Glow.sharedInstance.imageProfile {
            let url = URL(string: imgUrl)
            self.imgProfile.kf.setImage(with: url)
        }
        self.lblName.text = "\(UserDefaults.firstName ?? "") \(UserDefaults.lastName ?? "")"
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        
        DispatchQueue.main.async {
            
            self.imgProfile.layer.cornerRadius = self.imgProfile.bounds.height/2
            self.imgProfile.clipsToBounds = true
            
            self.nslcTableHeight.constant = self.tableView.contentSize.height
            self.tableView.layoutIfNeeded()
        }
    }
    
    // MARK: - Private methods
    private func decorateUI() {
        
        lblName.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        btnEditProfile.setUp(title: "Edit Profile".localized(), font: UIFont.Poppins.regular.size(FontSize.body_15), textColor: UIColor.AppColors.grayTextColor, bgColor: .clear)
        btnLogOut.setUp(title: "Log Out".localized(), font: UIFont.Poppins.regular.size(FontSize.body_15), textColor: .red, bgColor: .clear)
        tableView.reloadData()
    }
    
    // MARK: - IBActions
    @IBAction func onBtnEditProfileTap(sender: UIButton) {
        let editProfile = AppStoryboard.profile.viewController(viewcontrollerClass: EditProfileViewController.self)
        self.navigationController?.pushViewController(editProfile, animated: true)
    }
    
    @IBAction func onBtnLogOut_Tap(sender: UIButton) {
        
        let fcmToken = UserDefaults.standard.string(forKey: "fcmToken")
        self.logOutAcc(fcmToken: fcmToken ?? " ")
        
        _ = KeychainWrapper.standard.removeAllKeys()
        UserDefaults.standard.removeAll()



//        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: WelcomeViewController.identifier) as! WelcomeViewController
//        //initialViewController.mascotFor = .Welcome
//        let navController = UINavigationController(rootViewController: initialViewController)
//        navController.isNavigationBarHidden = true
//        if let window = UIApplication.shared.windows.first {
//            window.rootViewController = navController
//            window.makeKeyAndVisible()
    //    }
    }
    
    private func logOutAcc(fcmToken: String) {
        ProgressHUD.show()
        self.logOutViewModel.fcmToken = fcmToken
        
        self.logOutViewModel.logOut { isSuccess, error in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                    //Make dashboard root
                    let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
                    let initialViewController = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController")
                    let navController = UINavigationController(rootViewController: initialViewController)
                    navController.isNavigationBarHidden = true
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController = navController
                        window.makeKeyAndVisible()
                    }
                } else {
                    print("Oops!Something went wrong")
                    //self.showErrorToast(error)
                   // self.alertMessage(title: error ?? "Oops!Something went wrong")
                }
            }
        }
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileMenuCell.identifier) as! ProfileMenuCell
        cell.selectionStyle = .none
        let object = arrMenu[indexPath.row]
        cell.imgIcon.image = UIImage(named: object.icon)
        cell.lblTitle.text = object.title.localized()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = arrMenu[indexPath.row]
        switch object.id {
        case 1:
            let myActivity = AppStoryboard.profile.viewController(viewcontrollerClass: MyActivitiesViewController.self)
            self.navigationController?.pushViewController(myActivity, animated: true)
        case 2:
            let reflectionJournal = AppStoryboard.moduleSummary.viewController(viewcontrollerClass: ReflectionExpandableViewController.self)
            self.navigationController?.pushViewController(reflectionJournal, animated: true)
        case 3:
            let bookmarkedPages = AppStoryboard.profile.viewController(viewcontrollerClass: BookmarkedPagesViewController.self)
            self.navigationController?.pushViewController(bookmarkedPages, animated: true)
        case 4:
            let favModules = AppStoryboard.profile.viewController(viewcontrollerClass: FavouriteModulesViewController.self)
            self.navigationController?.pushViewController(favModules, animated: true)
//        case 5:
//            let faq = AppStoryboard.profile.viewController(viewcontrollerClass: FAQViewController.self)
//            self.navigationController?.pushViewController(faq, animated: true)
        default:
            let settingModule = AppStoryboard.profile.viewController(viewcontrollerClass: SettingsViewController.self)
            self.navigationController?.pushViewController(settingModule, animated: true)
        }
    }
}
