//
//  ReflectionJournalViewController.swift
//  Glow
//
//  Created by apple on 17/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit
import ProgressHUD

class ReflectionJournalViewController: UIViewController {
    
    static let identifier = "ReflectionJournalViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var txtVwJournal: UITextView!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var feebackSlider: UISlider!
    
    
    // MARK: - Variables
    let journalViewModel = ReflectionJournalViewModel()
    let vc = CustomPopViewController()
    var objUpNext: Unit?
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
        getReflectionJournalById()
        vc.onNextTap = { [weak self] in
            self?.vc.dismiss(animated: false, completion: nil)
            let webVC = WebViewController.instantiateFromAppStoryBoard(appStoryBoard: AppStoryboard.topics)
            webVC.objUnit = self?.objUpNext
            webVC.arrUnit = self?.journalViewModel.arrUnit ?? []
            self?.navigationController?.pushViewController(webVC, animated: true)
        }
        vc.onDashboardTap = { [weak self] in
            self?.vc.dismiss(animated: false, completion: {
                
                let controllers = self?.navigationController?.viewControllers
                              for vc in controllers! {
                                if vc is TopicsViewController {
                                  _ = self?.navigationController?.popToViewController(vc as! TopicsViewController, animated: true)
                                }
                             }
                
        })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        self.setTitle("Reflection Journal".localized(), isBackButton: true)
    }
    
    // MARK: - Private methods
    private func decorateUI() {
        
        lblTitle.setUp(title: "Reflection Journal", font: UIFont.Poppins.semiBold.size(FontSize.body_17), textColor: UIColor.AppColors.themeColor, noOfLine: 0)
        lblSubtitle.setUp(title: "What are some important things you learned?", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        lblNote.setUp(title: "You can access your journal within your profile.", font: UIFont.Poppins.regular.size(FontSize.body_15), textColor: UIColor.AppColors.gray3, noOfLine: 0)
        btnSubmit.setUp(title: "Submit", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, bgColor: UIColor.AppColors.themeColor, radius: Constant.viewRadius4)
        btnSkip.setUp(title: "Skip", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.themeColor, bgColor: UIColor.AppColors.whiteTextColor)
        
        txtVwJournal.textColor = UIColor.AppColors.darkTextColor
        txtVwJournal.font = UIFont.Poppins.regular.size(FontSize.body_15)
        txtVwJournal.textContainerInset = UIEdgeInsets(top: Constant.txtVwEdge, left: Constant.txtVwEdge, bottom: Constant.txtVwEdge, right: Constant.txtVwEdge)
        txtVwJournal.layer.cornerRadius = Constant.viewRadius4
        txtVwJournal.layer.borderWidth = Constant.viewBorder1
        txtVwJournal.layer.borderColor = UIColor.AppColors.greenBorder.cgColor
        txtVwJournal.placeholder = "High heels will most likely rub your skin and put pressure on toes and differnt parts of the foot."
        txtVwJournal.clipsToBounds = true
        txtVwJournal.leftSpace()
    }
    
    private func moveToNext() {
        if let currentIndex = self.journalViewModel.arrUnit.firstIndex(where: {$0.id == self.journalViewModel.unitId}) {
            if self.journalViewModel.arrUnit.count > currentIndex + 1 {
                self.objUpNext = self.journalViewModel.arrUnit[currentIndex+1]
                presentModalController(obj: self.objUpNext!)
                print("obj", self.objUpNext!)
                return
            }
        }
        let reviewVC = WriteReviewViewController.instantiateFromAppStoryBoard(appStoryBoard: AppStoryboard.moduleSummary)
        reviewVC.reviewViewModel.lessonId = self.journalViewModel.lessonId
        self.navigationController?.pushViewController(reviewVC, animated: true)
    }
    
    private func presentModalController(obj: Unit) {
        vc.setUpData(title: "Unit \(obj.position ?? 0)" , desc: obj.title ?? "")
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    // MARK: - API Call
    
    private func getReflectionJournalById() {
        
        ProgressHUD.show()
        journalViewModel.getReflectionJournalById { isSuccess, errMessage, reflectionJournals  in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
              
                if isSuccess {
                  
                    self.txtVwJournal.text = reflectionJournals?.data?.value
 
                    }
                   
                else {
                    self.showErrorToast(errMessage ?? "Journal Entry Already Exists")
                }
            }
        }

    }
    
    private func addReflectionJournal(value: String, sliderval: Int) {
        
        ProgressHUD.show()
        journalViewModel.value = value
        journalViewModel.numberValue = sliderval
        journalViewModel.addReflectionJournal {[weak self] isSuccess, error in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                self?.txtVwJournal.text = nil
                if isSuccess {
                    self?.showSuccessToast("Added to Journal")
                    self?.moveToNext()
                } else {
                    self?.showErrorToast(error ?? "Journal Entry Already Exists")
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
    
    // MARK: - IBActions
    @IBAction func onBtnSubmitTap(sender: UIButton) {
        guard let value = self.txtVwJournal.text, !value.trimWhiteSpace.isEmpty else {
            self.showErrorToast("Please enter reflection journal")
            return
        }
        var sliderVal = Int(self.feebackSlider.value) ?? 1
        self.txtVwJournal.resignFirstResponder()
        self.addReflectionJournal(value: value, sliderval: sliderVal)
    }
    
    @IBAction func onBtnSkip(_ sender: UIButton) {
        self.moveToNext()
    }
    
    
}
