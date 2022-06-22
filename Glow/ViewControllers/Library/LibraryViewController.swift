//
//  LibraryViewController.swift
//  Glow
//
//  Created by Nidhishree HP on 20/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit
import ProgressHUD
import Localize_Swift


class LibraryViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var lessonLabel: UILabel!
    // MARK: - Variables
    var viewType: LibraryView = .education
    var lessonsViewModel = EducationLessonViewModel()
    var quizBotViewModel = QuizBotViewModel()
    var arrBots = [Bot]()
    var titles = ["Education".localized(), "Conversations".localized()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*if viewType == .education {
         getLessons()
         }*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTitle("Library".localized())
        self.segmentWithTitles(titles: self.titles)
        self.decorateUI()
        if viewType == .education {
            getLessons()
        }
    }
    
    // MARK: - Private methods
    func decorateUI() {
        self.lessonLabel.setUp(title: "No Lessons".localized(),  font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .AppColors.darkTextColor, noOfLine: 1)
        self.lessonLabel.isHidden = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(nibWithCellClass: EducationTableViewCell.self)
        self.tableView.register(nibWithCellClass: QuizTableViewCell.self)
        
        self.segmentControl.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        
        // Segment Title setup
        let segSelectedAttributes: NSDictionary = [
            NSAttributedString.Key.foregroundColor: UIColor.AppColors.themeColor,
            NSAttributedString.Key.font: UIFont.Poppins.semiBold.size(FontSize.body_14)
        ]
        let segAttributes: NSDictionary = [
            NSAttributedString.Key.foregroundColor: UIColor.AppColors.grayTextColor,
            NSAttributedString.Key.font: UIFont.Poppins.semiBold.size(FontSize.body_14)
        ]
        self.segmentControl.setTitleTextAttributes(segSelectedAttributes as? [NSAttributedString.Key : Any], for: .selected)
        self.segmentControl.setTitleTextAttributes(segAttributes as? [NSAttributedString.Key : Any], for: .normal)
    }
    
    func segmentWithTitles(titles : [String])  {
        self.segmentControl.setTitle(titles[0], forSegmentAt: 0)
        self.segmentControl.setTitle(titles[1], forSegmentAt: 1)
        
    }
    // MARK: - Get lesson list
    func getLessons() {
        ProgressHUD.show()
        lessonsViewModel.getEducationLessonsList { status, error in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
            if status {
               
                    self.tableView.reloadData()
                
            } else {
                //self.showErrorToast(error)
                self.alertMessage(title: error ?? "Oops!Something went wrong")
                
            }
            if self.lessonsViewModel.lessonsSections.isEmpty ?? true {
                self.lessonLabel.isHidden = false
              
            } else {
                DispatchQueue.main.async {
                    self.lessonLabel.isHidden = true
                }
               
            }
            }
        }
    }
    
    func favouriteLesson(lessonId: String?) {
        guard let lessonId = lessonId else {
            return
        }
        ProgressHUD.show()
        lessonsViewModel.lessonId = lessonId
        lessonsViewModel.addLessonToFavourites { isSuccess, error in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                    self.getLessons()
                    self.showSuccessToast("Added to favourite")
                } else {
                    self.showErrorToast(error)
                }
            }
        }
    }
    
    func removeFavouriteLesson(lessonId: String?) {
        guard let lessonId = lessonId else {
            return
        }
        ProgressHUD.show()
        lessonsViewModel.lessonId = lessonId
        lessonsViewModel.removeLessonFromFavourite { isSuccess, error in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                    self.getLessons()
                    self.showSuccessToast("Removed from favourite")
                } else{
                    self.showErrorToast(error)
                }
            }
        }
    }
    
    func getQuizList() {
        ProgressHUD.show()
        quizBotViewModel.getQuizBotList { isSuccess, error, botResponse in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.arrBots = botResponse?.bots ?? []
                self.tableView.reloadData()
            }
            if (error != nil) {
                DispatchQueue.main.async {
                    self.alertMessage(title: error ?? "Oops!Something went wrong")
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
    
    // MARK: - segment switch action
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            viewType = .education
            getLessons()
        case 1:
            viewType = .quiz
            getQuizList()
        default:
            break
        }
    }
    
    @objc func onSeeAllTap(sender: UIButton) {
        let object = self.lessonsViewModel.lessonsSections[sender.tag]
        let reccommand = AppStoryboard.home.viewController(viewcontrollerClass: ReccommendedViewController.self)
        reccommand.lessonsViewModel.categoryId = object.id
        reccommand.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(reccommand, animated: true)
    }
    
    func navigateToUnits(lesson:EducationLesson) {
        let topicsVC = TopicsViewController.instantiateFromAppStoryBoard(appStoryBoard: .topics)
        topicsVC.lesson = lesson
        topicsVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(topicsVC, animated: true)
    }
    
    @IBAction func onBtnStartQuiz(sender: UIButton) {
        let botId = self.arrBots[sender.tag].id
        let chatbot = AppStoryboard.onboardingChatbot.viewController(viewcontrollerClass: DynamicChatbotViewController.self)
        chatbot.hidesBottomBarWhenPushed = true
        chatbot.botId = botId
        self.navigationController?.pushViewController(chatbot, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewType {
        case .education:
            return self.lessonsViewModel.lessonsSections.count
        case .quiz:
            return self.arrBots.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewType {
        case .education:
            let cell = tableView.dequeueReusableCell(withClass: EducationTableViewCell.self, for: indexPath)
            cell.contentView.backgroundColor = indexPath.row % 2 == 0 ?
            UIColor.AppColors.cellBackground : UIColor.AppColors.whiteTextColor
            cell.lessonsSection = self.lessonsViewModel.lessonsSections[indexPath.row]
            cell.onClickFavourite = { lesson in
                if (lesson?.favourites ?? []).isEmpty {
                    self.favouriteLesson(lessonId: lesson?.id)
                } else {
                    self.removeFavouriteLesson(lessonId: lesson?.id)
                    print(lesson?.id)
                }
            }
            cell.onClickBookmarks = {
                
            }
            cell.onClickLesson = { lesson in
                self.navigateToUnits(lesson:lesson)
            }
            cell.seeAllButton.tag = indexPath.row
            cell.seeAllButton.addTarget(self, action: #selector(onSeeAllTap(sender:)), for: .touchUpInside)
            return cell
        case .quiz:
            let object = self.arrBots[indexPath.row]
            let cell = tableView.dequeueReusableCell(withClass: QuizTableViewCell.self, for: indexPath)
            cell.separator.isHidden = indexPath.row == (tableView.numberOfRows(inSection: 0) - 1) ? true : false
            cell.objectBot = object
            cell.startQuizButton.tag = indexPath.row
            cell.startQuizButton.addTarget(self, action: #selector(onBtnStartQuiz(sender:)), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewType {
        case .education: return Constant.educationTableCellHeight
        default:
            return UITableView.automaticDimension
        }
    }
}
