//
//  TopicsViewController.swift
//  Glow
//
//  Created by Pushpa Yadav on 21/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit


enum TabIndex : Int {
    case firstChildTab = 0
    case secondChildTab = 1
}
class TopicsViewController: UIViewController {
    
    static let identifier = "TopicsViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUnitCount: UILabel!
    @IBOutlet weak var unitProgress: UIProgressView!
    @IBOutlet weak var lblUnitProgress: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnUnits: UIButton!
    @IBOutlet weak var lblUnits: UILabel!
    @IBOutlet weak var btnComments: UIButton!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    // MARK: - Variables
    var selectedIndex = 0
    var lesson:EducationLesson?
    var currentViewController: UIViewController?
    lazy var firstChildTabVC: UIViewController? = {
        let firstChildTabVC = UnitsViewController.instantiateFromAppStoryBoard(appStoryBoard: .topics)
        if let object = lesson {
            firstChildTabVC.objUnitViewModel.lessonId = object.id
        } else {
            firstChildTabVC.objUnitViewModel.lessonId = lessonsViewModel.lessonId
        }
        return firstChildTabVC
    }()
    lazy var secondChildTabVC : UIViewController? = {
        let secondChildTabVC = CommentsViewController.instantiateFromAppStoryBoard(appStoryBoard: .topics)
        if let object = lesson {
            secondChildTabVC.objCommentViewModel.lessonId = object.id
        } else {
            secondChildTabVC.objCommentViewModel.lessonId = lessonsViewModel.lessonId
        }
        return secondChildTabVC
    }()
    var lessonsViewModel = EducationLessonViewModel()
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decorateUI()
        setUpData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTitle("", isBackButton: true)
        displayCurrentTab(self.selectedIndex)
    }
    
    override func onBtnRightClick(sender: UIBarButtonItem) {
        if sender.tag == 100 {
            if (self.lesson?.favourites ?? []).isEmpty {
                self.favouriteLesson(lessonId: self.lesson?.id)
            } else {
                print(self.lesson?.id)
                self.removeFavouriteLesson(lessonId: self.lesson?.id)
            }
        }
    }
    
    // MARK: - Private methods
    private func decorateUI() {
        
        imgHeader.layer.cornerRadius = Constant.viewRadius8
        imgHeader.clipsToBounds = true
        
        
        lblTitle.setUp(title: "Welcome to Module 5", font: UIFont.Poppins.semiBold.size(FontSize.body_17), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        
        lblTitle.setUp(title: "", font: UIFont.Poppins.semiBold.size(FontSize.body_17), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        
        [lblUnitCount, lblUnitProgress].forEach { lbl in
            lbl?.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.subtitle_11), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
        }
        
        lblDesc.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        unitProgress.trackTintColor = UIColor.AppColors.FCECFF
        unitProgress.progressTintColor = UIColor.AppColors.themeColor
        lblDesc.text = """
                        At the end of this module,  You will:\n
                        \u{2022} Understand the ways diabetes impacts feet\n
                        \u{2022} Know how to spot early signs complications and what to do\n
                        \u{2022} Know how to care for your feet
                        """
        
        lblDesc.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        unitProgress.trackTintColor = UIColor.AppColors.FCECFF
        unitProgress.progressTintColor = UIColor.AppColors.themeColor
        
        
        btnUnits.setUp(title: "Units".localized(), font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: UIColor.AppColors.darkTextColor, bgColor: .clear)
        btnComments.setUp(title: "Comment".localized(), font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: UIColor.AppColors.darkTextColor, bgColor: .clear)
    }
    
    private func setUpData() {
        if let object = self.lesson {
            if let imgUrl = object.imageUrl, let encodedUrl = imgUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                let url = URL(string: encodedUrl)
                self.imgHeader.kf.setImage(with: url)
            }
            self.lblTitle.text = object.name ?? ""
            self.lblDesc.text = object.description ?? ""
            self.lblUnitCount.text = "\(object.pageCount ?? 0) units"
            let progressIs = Float(object.participantCompletedUnit ?? 0)/Float(object.pageCount ?? 0)
            self.lblUnitProgress.text = "\(Int(progressIs*100))% Completed"
            self.unitProgress.progress = progressIs
            let imageName = (object.favourites ?? []).isEmpty ? "favourite" : "unfavourite"
            self.setUpNavRightBar(image: [imageName], tags: [100])
            self.lblUnits.backgroundColor = UIColor.AppColors.darkTextColor
        } else if self.lessonsViewModel.lessonId != nil {
            self.getLessonDetail()
        }
    }
    
    func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            self.addChild(vc)
            vc.didMove(toParent: self)
            vc.view.frame = self.viewContainer.bounds
            self.viewContainer.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    func switchTabs() {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParent()
        displayCurrentTab(self.selectedIndex)
    }
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.firstChildTab.rawValue :
            vc = firstChildTabVC
        case TabIndex.secondChildTab.rawValue :
            vc = secondChildTabVC
        default:
            return nil
        }
        return vc
    }
    
    // MARK: - API Calls
    private func getLessonDetail() {
        ProgressHUD.show()
        lessonsViewModel.getEducationLessonByLessonId { issuccess, error, object in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if issuccess {
                    self.lesson = object
                    self.setUpData()
                } else {
                    //self.showErrorToast(error)
                    self.alertMessage(title: error ?? "Oops!Something went wrong")
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
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                    self.lesson?.favourites?.append(Favourite(id: "xxx"))
                    self.setUpNavRightBar(image: ["unfavourite"], tags: [100])
                    self.showSuccessToast("Added to favourite")
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
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                    self.lesson?.favourites = nil
                    self.setUpNavRightBar(image: ["favourite"], tags: [100])
                    self.showSuccessToast("Removed from favourite")
                } else {
                    self.showErrorToast(error)
                }
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func onBtnUnitsTap(sender: UIButton) {
        self.selectedIndex = 0
        switchTabs()
        lblUnits.backgroundColor = UIColor.AppColors.darkTextColor
        lblComments.backgroundColor = .clear
    }
    
    @IBAction func onBtnCommentsTap(sender: UIButton) {
        self.selectedIndex = 1
        switchTabs()
        lblComments.backgroundColor = UIColor.AppColors.darkTextColor
        lblUnits.backgroundColor = .clear
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
