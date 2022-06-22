//
//  HomeViewController.swift
//  Glow
//
//  Created by Nidhishree HP on 08/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    static let identifier = "HomeViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblGreeting: UILabel!
    @IBOutlet weak var imgVwProfile: UIImageView!
    @IBOutlet weak var vwAskAQue: UIView!
    @IBOutlet weak var imgVwAskAQue: UIImageView!
    //@IBOutlet weak var lblAskAQue: UILabel!
    @IBOutlet weak var lblUnlockConfusion: UILabel!
    @IBOutlet weak var btnAskAQue: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    var homeViewModel = HomeViewModel()
//    var FAQViewModel = getFAQViewModel()
//    var fAQTopics = [Topic]()
   
    let specing: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 32 : 16
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        let token = Constant.loginConstants.authToken
//        print(token)
        decorateUI()
    
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(nibWithCellClass: HomeCollectionViewCell.self, at: nil)
        collectionView.register(nibWithCellClass: HomeCVCell.self, at: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onImageProfileTap(gesture:)))
        imgVwProfile.isUserInteractionEnabled = true
        imgVwProfile.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        //self.tabBarController?.tabBar.isHidden = false
//        self.lblName.text = "Hi \(Glow.sharedInstance.firstName ?? "")"
        decorateUI()
    }
    
    // MARK: - Private methods
    private func decorateUI() {

        let strName = "Hi".localized() + " \(UserDefaults.firstName ?? "") \(UserDefaults.lastName ?? "")"
        lblName.setUp(title: strName, font: UIFont.Poppins.semiBold.size(FontSize.headline_19), textColor: UIColor.AppColors.darkTextColor, noOfLine: 1)
        lblGreeting.setUp(title: "Good to see you’re back at it.".localized(), font: UIFont.Poppins.regular.size(FontSize.body_15), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        
        imgVwProfile.layer.cornerRadius = Constant.viewRadius8
        imgVwProfile.layer.borderWidth = Constant.viewBorder
        imgVwProfile.layer.borderColor = UIColor.AppColors.lightPink.cgColor
        imgVwProfile.clipsToBounds = true
        
//        vwAskAQue.layer.cornerRadius = Constant.viewRadius8
//        vwAskAQue.layer.borderWidth = Constant.viewBorder1
//        vwAskAQue.layer.borderColor = UIColor.AppColors.EDC7F5.cgColor
//        vwAskAQue.clipsToBounds = true
//        vwAskAQue.backgroundColor = UIColor.AppColors.askAQue
        
        
      //  lblUnlockConfusion.layer.cornerRadius = Constant.viewRadius8
        lblUnlockConfusion.clipsToBounds = true
        lblUnlockConfusion.backgroundColor = UIColor.AppColors.askAQue
        
        
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.lblUnlockConfusion.bounds, byRoundingCorners: [.topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: Constant.viewRadius16, height: Constant.viewRadius16))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.lblUnlockConfusion.layer.mask = mask
        }
        
        imgVwAskAQue.layer.cornerRadius = Constant.viewRadius4
        imgVwAskAQue.clipsToBounds = true
        
       // lblAskAQue.setUp(title: "Ask a question?".localized(), font: UIFont.Poppins.semiBold.size(FontSize.body_17), textColor: UIColor.AppColors.themeColor, noOfLine: 1)
        //lblUnlockConfusion.setUp(title: "Unblock all your confusions with Glow".localized(), font: UIFont.Poppins.medium.size(FontSize.subtitle_11), textColor: UIColor.AppColors.grey, noOfLine: 0)
        btnAskAQue.setUpBlank()
        
        collectionView.reloadData()
       // self.getFAQQuestionList()
    }
    
    
  
    // MARK: - Tap gesture
    @objc func onImageProfileTap(gesture: UIGestureRecognizer) {
        let profile = AppStoryboard.profile.viewController(viewcontrollerClass: ProfileViewController.self)
        profile.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(profile, animated: true)
     
        
        
    }
    
    // MARK: - IBAction
    @IBAction func onBtnAskAQusTap(sender: UIButton) {
        let chatbot = AppStoryboard.home.viewController(viewcontrollerClass: FAQChatBotViewController.self)
      
        chatbot.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatbot, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.arrTiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let cell = collectionView.dequeueReusableCell(withClass: HomeCollectionViewCell.self, for: indexPath)
        let cell = collectionView.dequeueReusableCell(withClass: HomeCVCell.self, for: indexPath)
        let object = self.homeViewModel.arrTiles[indexPath.item]
        cell.object = object
        //        cell.tilebackground.backgroundColor = object.color
        //        cell.tileImage.image = UIImage(named: object.image)
        //        cell.tileTiles.text = object.title
        //        cell.tileTopicsCount.text = object.subTitle
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = self.homeViewModel.arrTiles[indexPath.item]
        if object.id == 1 {
            let reccommand = AppStoryboard.home.viewController(viewcontrollerClass: ReccommendedViewController.self)
            reccommand.hidesBottomBarWhenPushed = true
            reccommand.lessonsViewModel.tab = "recommended"
            reccommand.displayData = "No Recommended Lessons"
            self.navigationController?.pushViewController(reccommand, animated: true)
        } else if object.id == 2 {
            let reccommand = AppStoryboard.home.viewController(viewcontrollerClass: ReccommendedViewController.self)
            reccommand.hidesBottomBarWhenPushed = true
            reccommand.lessonsViewModel.tab = "continue_learning"
            reccommand.displayData = "No Lessons are pending"
            self.navigationController?.pushViewController(reccommand, animated: true)
        } else if object.id == 3 {
            let reccommand = AppStoryboard.home.viewController(viewcontrollerClass: ReccommendedViewController.self)
            reccommand.hidesBottomBarWhenPushed = true
            reccommand.lessonsViewModel.tab = "completed"
            reccommand.displayData = "No Completed Lessons"
            self.navigationController?.pushViewController(reccommand, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //        let cellWidth = (collectionView.bounds.width-specing) / 2
        //        let cellHeight = cellWidth * 1.14
        //        return CGSize(width: cellWidth, height: cellHeight)
        let cellWidth = collectionView.bounds.width
        let cellHeight = cellWidth / 3.68
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return specing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return specing
    }
    
}

//extension String{
//    func localized() -> String {
//        return NSLocalizedString(self, tableName: "Home", bundle: .main, value: self, comment: self)
//    }
//}

//extension ViewController : LanguageSelectionDelegate{
//    
//    func settingsViewController(_ settingsViewController: SettingsViewController, didSelectLanguage language: Language) {
//
////  Set selected language to application language
//        RKLocalization.sharedInstance.setLanguage(language: language.languageCode)
//        
////  Reload application bundle as new selected language
//        DispatchQueue.main.async(execute: {
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.initRootView()
//        })
//    }
//}
