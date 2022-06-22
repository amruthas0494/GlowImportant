//
//  ModuleSummaryViewController.swift
//  Glow
//
//  Created by apple on 16/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class ModuleSummaryViewController: UIViewController {
    
    static let identifier = "ModuleSummaryController"
    
    // MARK: - Outlets
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var txtVwSummary: UITextView!
    @IBOutlet weak var btnDone: UIButton!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    // MARK: - Variables
    var summaryText : [String] = []
    var unitId: String?
    var objModuleSummary = CommentViewModel()
    let vc = CustomPopViewController()
    let lessonReviewVM = LessonReviewViewModel()
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelText.setUp(title: "Congratulations! We've reached the end of module 5!", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
//        self.checkText1.setUp(title: "You already know why caring for your feet is important", font: UIFont.Poppins.regular.size(FontSize.body_15), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
//        self.checkText2.setUp(title: "You already know how to spot early signs of complications and what to do (Inspection and Intervention)", font: UIFont.Poppins.regular.size(FontSize.body_15), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
//        self.checkText3.setUp(title: "You already know how to care for your feet properly (Hygiene and Protection)", font: UIFont.Poppins.regular.size(FontSize.body_15), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
//        self.detailedNote.setUp(title: "Diabetes affects feet by damaging nerves and veins", font: UIFont.Poppins.regular.size(FontSize.body_13), textColor: UIColor.AppColors.gray3, noOfLine: 0)
//        
//        self.check1.image = UIImage(systemName: "checkmark")
//        self.check1.image?.withTintColor(UIColor.AppColors.themeColor)
//        self.check2.image = UIImage(systemName: "checkmark")
//        self.check2.image?.withTintColor(UIColor.AppColors.themeColor)
//        self.check3.image = UIImage(systemName: "checkmark")
//        self.check3.image?.withTintColor(UIColor.AppColors.themeColor)
        self.labelText.setUp(title: "Congratulations! We've reached the end of module!", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        
        vc.onNextTap = { [weak self] in
            self?.vc.dismiss(animated: false) {
                self?.navigationController?.popToRootViewController(animated: true)
            }
        }
        vc.onDashboardTap = { [weak self] in
            self?.vc.dismiss(animated: false, completion: {
                self?.navigationController?.popToRootViewController(animated: true)
            })
        }
        decorateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTitle("Module Summary", isBackButton: true)
       // self.setTitle("Module Summary".localized(), isBackButton: true)
        self.getModuleSummary()
    }
    
    // MARK: - Private methods
    private func decorateUI() {
        headerLabel.setUp(title: "Module Summary", font: UIFont.Poppins.semiBold.size(FontSize.body_17), textColor: UIColor.AppColors.themeColor, noOfLine: 0)
        self.btnDone.setUp(title: "Done", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: .white, bgColor: .AppColors.themeColor, radius: Constant.viewRadius4)
    }
    
    @IBAction func onBtnDone_Tap(sender: UIButton) {
        vc.setUpForComplete()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    // MARK: - API Call
    private func getModuleSummary() {
        
        ProgressHUD.show()
        self.lessonReviewVM.moduleSummaryForLesson { isSuccess, error, object in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.txtVwSummary.attributedText = (object?.summary ?? "").htmlToAttributedString
            }
        }
    }
}
