//
//  OnboardingChatbotViewController.swift
//  Glow
//
//  Created by Pushpa Yadav on 22/11/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import ProgressHUD

class OnboardingChatbotViewController: UIViewController {
    
    static let identifier = "OnboardingChatbotViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var vwNavigation: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var vwOnline: UIView!
    @IBOutlet weak var lblOnline: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var tblChatboat: UITableView!
    
    // MARK: - Variables
    let loginViewModel = LoginViewModel()
    let onboardingViewModel = OnboardingChatbotViewModel()
    
    var arrChatContent: [(text: String, type: ChatbotCell, redirectTo: String?, time: String?, step:OnboardingStep)] = []
    var messageIndex = 0
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
        registerTableCell()
        self.reloadAndScrollToBottom()
        
        onboardingViewModel.delegate = self
        //self.postOnboardingProgress(data: [:], displayData: "")
        onboardingViewModel.getOnboardingStatus { [weak self] in
            self?.onOnboardingCompletion()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Private methods
    private func decorateUI() {
        
        lblTitle.setUp(title: "Glow".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .AppColors.blackText, noOfLine: 1)
        lblOnline.setUp(title: "Online".Chatbotlocalized(), font: UIFont.Poppins.regular.size(FontSize.subtitle_12), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
        
        vwOnline.layer.cornerRadius = vwOnline.bounds.height/2
        vwOnline.clipsToBounds = true
        
        btnBack.setUpBlank()
        
        // btnSearch.setUpBlank()
    }
    
    private func registerTableCell() {
        
        self.tblChatboat.delegate = self
        self.tblChatboat.dataSource = self
        self.tblChatboat.separatorStyle = .none
        self.tblChatboat.register(nibWithCellClass: TypingCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: typeOneTableViewCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: ReadingFontSizeCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: LeftTextViewCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: RightButtonCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: RightTextViewCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: genderSelectCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: StudyNumberTableViewCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: CreateAccountCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: LeftImageWithTextCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: EmailVerifyCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: MobileVerifyCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: OTPVerifyCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: LoginCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: ForgotPasswordCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: GenderSelectionCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: DatePickerCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: SliderCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: LeftPersonalProgramCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: AgeCell.self, at: nil)
    }
    
    private func showTyping() {
        self.arrChatContent.append(("", type: .typing, redirectTo: nil, time: nil, step:.typing ))
        self.reloadAndScrollToBottom()
    }
    
    private func hideTyping() {
        self.arrChatContent.removeLast()
        self.reloadAndScrollToBottom()
    }
    
    private func removeOptions() {
        if let lastType = arrChatContent.last, lastType.type == .button {
            for object in self.arrChatContent.reversed() {
                if object.type == .button {
                    self.arrChatContent.removeLast()
                } else {
                    break
                }
            }
        } else {
            self.arrChatContent.removeLast()
        }
    }
    
    private func showStartTyping(completion: @escaping ()->()) {
        
        var seconds = 5
        self.arrChatContent.append(("", ChatbotCell.typing, nil, nil,OnboardingStep.typing))
        self.reloadAndScrollToBottom()
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            seconds -= 1
            if seconds == 0 {
                timer.invalidate()
                self.arrChatContent.removeLast()
                completion()
            }
        }
    }
    
    func reloadAndScrollToBottom() {
        self.tblChatboat.reloadData()
        DispatchQueue.main.async {
            if !self.arrChatContent.isEmpty {
                let indexPath = IndexPath(row: self.arrChatContent.count-1, section: 0)
                self.tblChatboat.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    func onOnboardingCompletion() {
        self.arrChatContent.append(("Redirecting to login", ChatbotCell.textView, nil, nil, OnboardingStep.letsBegin))
        self.reloadAndScrollToBottom()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: LoginViewController.identifier) as? LoginViewController {
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
        }
    }
    
    // MARK: - IBAction
    @IBAction func onBtnBack(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - API Call
extension OnboardingChatbotViewController {
    
    private func postOnboardingProgress(data: Dictionary<String, Any>?, displayData: String?) {
        
        ProgressHUD.show()
        onboardingViewModel.data = data
        onboardingViewModel.onboardingProgress { isSuccess, error, onboardingProgress in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                    if let object = onboardingProgress, object.success ?? false {
                        if let token = object.data?.token {
                            UserDefaults.onboardToken = token
                        }
                        self.removeOptions()
                        //if displayData != ""  {
                            if let displayData = displayData {
                                self.arrChatContent.append((displayData, ChatbotCell.rightTextView, nil, Date().toString(format: "h:mm a"), OnboardingStep.themeSelect))
                            }
                            
                       // }
                        self.reloadAndScrollToBottom()
                        if object.next ?? false {
                            self.onboardingViewModel.loadNextStep(object: object)
                        } else {
                            // move to mascot screen
                            if let initialViewController = self.storyboard?.instantiateViewController(withIdentifier: MascotPersonViewController.identifier) as? MascotPersonViewController {
                                initialViewController.mascotFor = .ThankYou
                                self.navigationController?.pushViewController(initialViewController, animated: true)
                            }
                        }
                    } else if let object = onboardingProgress?.data,
                              let userId = object.id,
                              let email = object.email,
                              let token = object.token {
                        
                        //Move to dashboard
                        KeychainWrapper.standard.set(token, forKey: Constant.loginConstants.authToken)
                        UserDefaults.userId = userId
                        UserDefaults.email = email
                        UserDefaults.firstName = object.firstName
                        UserDefaults.lastName = object.lastName
                        UserDefaults.userProfile = object.profileImage
                        
                        //Make dashboard root
                        let storyboard = UIStoryboard(name: "HomeTab", bundle: nil)
                        let initialViewController = storyboard.instantiateViewController(withIdentifier: "HomeTabBarController")
                        let navController = UINavigationController(rootViewController: initialViewController)
                        navController.isNavigationBarHidden = true
                        if let window = UIApplication.shared.windows.first {
                            window.rootViewController = navController
                            window.makeKeyAndVisible()
                        }
                    }
                } else {
                    self.showErrorToast(error)
                    // self.alertMessage(title: error ?? "Oops!Something went wrong")
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension OnboardingChatbotViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrChatContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = arrChatContent[indexPath.row]
        switch object.step {
        case .typing:
            let cell = tableView.dequeueReusableCell(withClass: TypingCell.self)
            cell.selectionStyle = .none
            cell.startAnimation()
            return cell
        case .themeSelect:
            switch object.type {
            case .textView:
                let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                cell.selectionStyle = .none
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            case .button:
                let cell = tableView.dequeueReusableCell(withClass: RightButtonCell.self)
                cell.selectionStyle = .none
                let object = self.arrChatContent[indexPath.row]
                cell.lblTitle.text = object.text
                cell.action = object.redirectTo ?? onboardingViewModel.currentStep.rawValue
                cell.btnOption.addTarget(self, action: #selector(onButtonTap(sender:)), for: .touchUpInside)
                return cell
            case .rightTextView:
                let cell = tableView.dequeueReusableCell(withClass: RightTextViewCell.self)
                cell.selectionStyle = .none
                let object = self.arrChatContent[indexPath.row]
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            default:
                break
            }
        case .fontSelect:
            switch object.type {
            case .textView:
                let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                cell.selectionStyle = .none
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            case .readingFontSize:
                let cell = tableView.dequeueReusableCell(withClass: ReadingFontSizeCell.self)
                cell.selectionStyle = .none
                cell.btnFont14.tag = 14
                cell.btnFont14.addTarget(self, action: #selector(onReadingFontSizeSelection(sender:)), for: .touchUpInside)
                cell.btnFont16.tag = 16
                cell.btnFont16.addTarget(self, action: #selector(onReadingFontSizeSelection(sender:)), for: .touchUpInside)
                cell.btnFont18.tag = 18
                cell.btnFont18.addTarget(self, action: #selector(onReadingFontSizeSelection(sender:)), for: .touchUpInside)
                cell.btnFont20.tag = 20
                cell.btnFont20.addTarget(self, action: #selector(onReadingFontSizeSelection(sender:)), for: .touchUpInside)
                return cell
            case .rightTextView:
                let cell = tableView.dequeueReusableCell(withClass: RightTextViewCell.self)
                cell.selectionStyle = .none
                let object = self.arrChatContent[indexPath.row]
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            default:
                break
            }
        case .fontPreview:
            switch object.type {
            case .textView:
                let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                cell.selectionStyle = .none
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                if object.text.lowercased().contains("hello david this font") {
                    let fontSize: CGFloat = CGFloat(UserDefaults.prefFontSize)
                    cell.lblText.text = object.text + " \(UserDefaults.prefFontSize)"
                    cell.changeFontSize(size: fontSize)
                }
                //self.postOnboardingProgress(data: [:], displayData: "")
                return cell
            case .button:
                let cell = tableView.dequeueReusableCell(withClass: RightButtonCell.self)
                cell.selectionStyle = .none
                let object = self.arrChatContent[indexPath.row]
                cell.lblTitle.text = object.text
                cell.action = object.redirectTo ?? onboardingViewModel.currentStep.rawValue
                cell.btnOption.addTarget(self, action: #selector(onButtonTap(sender:)), for: .touchUpInside)
                return cell
            case .rightTextView:
                let cell = tableView.dequeueReusableCell(withClass: RightTextViewCell.self)
                cell.selectionStyle = .none
                let object = self.arrChatContent[indexPath.row]
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            default:
                break
            }
        case .futureSignInOpt:
            switch object.type {
            case .textView:
                let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                cell.selectionStyle = .none
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            case .button:
                let cell = tableView.dequeueReusableCell(withClass: RightButtonCell.self)
                cell.selectionStyle = .none
                let object = self.arrChatContent[indexPath.row]
                cell.lblTitle.text = object.text
                cell.action = object.redirectTo ?? onboardingViewModel.currentStep.rawValue
                cell.btnOption.addTarget(self, action: #selector(onButtonTap(sender:)), for: .touchUpInside)
                return cell
            case .rightTextView:
                let cell = tableView.dequeueReusableCell(withClass: RightTextViewCell.self)
                cell.selectionStyle = .none
                let object = self.arrChatContent[indexPath.row]
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            default:
                break
            }
        case .studyNumber :
            switch object.type {
            case .textView:
                let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                cell.selectionStyle = .none
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            case .studyNumber:
                let cell = tableView.dequeueReusableCell(withClass: StudyNumberTableViewCell.self)
                // cell.tag = 0
                cell.selectionStyle = .none
                //  cell.lblAge.text = "Study Number"
                cell.studyNumberTextField.text = ""
                // cell.btnSubmit.tag = indexPath.row
                cell.submitButton.addTarget(self, action: #selector(onStudyNumberSubmit(sender:)), for: .touchUpInside)
                return cell
            default:
                break
            }
        case .inputNickName:
            switch object.type {
            case .textView:
                let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                cell.selectionStyle = .none
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            case .calledName:
                let cell = tableView.dequeueReusableCell(withClass: EmailVerifyCell.self)
                cell.tag = 1
                cell.selectionStyle = .none
                cell.lblEmail.text = ""
                cell.txtEmail.text = ""
                cell.btnSubmit.tag = indexPath.row
                cell.btnSubmit.addTarget(self, action: #selector(onFullNameSubmit(sender:)), for: .touchUpInside)
                return cell
            default:
                break
            }
        case .inputDOB:
            switch object.type {
            case .textView:
                let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                cell.selectionStyle = .none
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            case .inputDOB:
                let cell = tableView.dequeueReusableCell(withClass: AgeCell.self)
                cell.tag = 1
                cell.lblAge.text = ""
                cell.txtAge.text = ""
                cell.selectionStyle = .none
                cell.btnSubmit.tag = indexPath.row
                cell.btnSubmit.addTarget(self, action: #selector(onAgeSubmit(sender:)), for: .touchUpInside)
                return cell
            default:
                break
            }
        case .genderSelect:
            switch object.type {
            case .textView:
                let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                cell.selectionStyle = .none
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            case .genderSelection:
                let cell = tableView.dequeueReusableCell(withClass: genderSelectCell.self)
                
                cell.maleButton.tag = 1
                cell.maleButton.addTarget(self, action: #selector(onBtnGenderSelection(sender:)), for: .touchUpInside)
                cell.femaleButton.tag = 2
                cell.femaleButton.addTarget(self, action: #selector(onBtnGenderSelection(sender:)), for: .touchUpInside)
                cell.othersButton.tag = 3
                cell.othersButton.addTarget(self, action: #selector(onBtnGenderSelection(sender:)), for: .touchUpInside)
                return cell
            default:
                break
            }
        case .ethniticySelect:
            switch object.type {
            case .textView:
                let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                cell.selectionStyle = .none
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            case .button:
                let cell = tableView.dequeueReusableCell(withClass: RightButtonCell.self)
                cell.selectionStyle = .none
                let object = self.arrChatContent[indexPath.row]
                cell.lblTitle.text = object.text
                cell.action = object.redirectTo ?? onboardingViewModel.currentStep.rawValue
                cell.btnOption.addTarget(self, action: #selector(onButtonTap(sender:)), for: .touchUpInside)
                return cell
            case .rightTextView:
                let cell = tableView.dequeueReusableCell(withClass: RightTextViewCell.self)
                cell.selectionStyle = .none
                let object = self.arrChatContent[indexPath.row]
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            default:
                break
            }
        case .describeYourself:
            switch object.type {
            case .textView:
                let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                cell.selectionStyle = .none
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            case .button:
                let cell = tableView.dequeueReusableCell(withClass: RightButtonCell.self)
                cell.selectionStyle = .none
                let object = self.arrChatContent[indexPath.row]
                cell.lblTitle.text = object.text
                cell.action = object.redirectTo ?? onboardingViewModel.currentStep.rawValue
                cell.btnOption.addTarget(self, action: #selector(onButtonTap(sender:)), for: .touchUpInside)
                return cell
            case .rightTextView:
                let cell = tableView.dequeueReusableCell(withClass: RightTextViewCell.self)
                cell.selectionStyle = .none
                let object = self.arrChatContent[indexPath.row]
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            default:
                break
            }
        case .typeOneDiabetesSelect:
            
            let cell = tableView.dequeueReusableCell(withClass: typeOneTableViewCell.self)
            
            cell.selectionStyle = .none
            cell.lblText.text = object.text
            cell.lblTime.text = object.time
          
            return cell
            
            self.postOnboardingProgress(data: [:], displayData: "")
        
    case .inputPatientName:
        switch object.type {
        case .textView:
            let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
            cell.selectionStyle = .none
            cell.lblText.text = object.text
            cell.lblTime.text = object.time
            return cell
        case .calledName:
            let cell = tableView.dequeueReusableCell(withClass: EmailVerifyCell.self)
            cell.tag = 1
            cell.selectionStyle = .none
            cell.lblEmail.text = ""
            cell.txtEmail.text = ""
            cell.btnSubmit.tag = indexPath.row
            cell.btnSubmit.addTarget(self, action: #selector(onFullNameSubmit(sender:)), for: .touchUpInside)
            return cell
        default:
            break
        }
    case .diabetesDiscoverySelect:
        switch object.type {
        case .textView:
            let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
            cell.selectionStyle = .none
            cell.lblText.text = object.text
            cell.lblTime.text = object.time
            return cell
        case .diabetesDiscoverySelect :
            let cell = tableView.dequeueReusableCell(withClass: AgeCell.self)
            cell.tag = 2
            cell.selectionStyle = .none
            cell.lblAge.text = ""
            cell.txtAge.text = ""
            cell.btnSubmit.tag = indexPath.row
            cell.btnSubmit.addTarget(self, action: #selector(ondiabetesDiscoverySelect(sender:)), for: .touchUpInside)
            return cell
        default:
            break
        }
        case .learningInterestScale:
            switch object.type {
            case .textView:
                let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                cell.selectionStyle = .none
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            case .slider:
            let cell = tableView.dequeueReusableCell(withClass: SliderCell.self)
            cell.selectionStyle = .none
            cell.slider.isContinuous = false
            cell.action = object.redirectTo
            cell.slider.tag = indexPath.row
            cell.slider.addTarget(self, action: #selector(onSliderValueChange(sender:)), for: .valueChanged)
            return cell
            default:
                break
            }
        case .learningInterestScaleLess:
            switch object.type {
            case .textView:
                let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                cell.selectionStyle = .none
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                self.postOnboardingProgress(data: [:], displayData: "")
                return cell
            default:
               break
            }
               
        case .learningInterestScaleMore:
            let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
            cell.selectionStyle = .none
            cell.lblText.text = object.text
            cell.lblTime.text = object.time
            self.postOnboardingProgress(data: [:], displayData: "")
            return cell
       
        case .improvementChangeSelect:
            switch object.type {
            case .textView:
                let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                cell.selectionStyle = .none
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            case .button:
                let cell = tableView.dequeueReusableCell(withClass: RightButtonCell.self)
                cell.selectionStyle = .none
                let object = self.arrChatContent[indexPath.row]
                cell.lblTitle.text = object.text
                cell.action = object.redirectTo ?? onboardingViewModel.currentStep.rawValue
                cell.btnOption.addTarget(self, action: #selector(onButtonTap(sender:)), for: .touchUpInside)
                return cell
            case .rightTextView:
                let cell = tableView.dequeueReusableCell(withClass: RightTextViewCell.self)
                cell.selectionStyle = .none
                let object = self.arrChatContent[indexPath.row]
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            default:
                break
            }
        case .improvementChangeSelectNull:
            let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
            cell.selectionStyle = .none
            cell.lblText.text = object.text
            cell.lblTime.text = object.time
            self.postOnboardingProgress(data: [:], displayData: "")
            return cell
        case .optNotification:
            switch object.type {
            case .textView:
                let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                cell.selectionStyle = .none
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            case .button:
                let cell = tableView.dequeueReusableCell(withClass: RightButtonCell.self)
                cell.selectionStyle = .none
                let object = self.arrChatContent[indexPath.row]
                cell.lblTitle.text = object.text
                cell.action = object.redirectTo ?? onboardingViewModel.currentStep.rawValue
                cell.btnOption.addTarget(self, action: #selector(onButtonTap(sender:)), for: .touchUpInside)
                return cell
            case .rightTextView:
                let cell = tableView.dequeueReusableCell(withClass: RightTextViewCell.self)
                cell.selectionStyle = .none
                let object = self.arrChatContent[indexPath.row]
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            default:
                break
            }
        case .optNotificationYes:
            switch object.type {
            case .textView:
                let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                cell.selectionStyle = .none
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            case .button:
                let cell = tableView.dequeueReusableCell(withClass: RightButtonCell.self)
                cell.selectionStyle = .none
                let object = self.arrChatContent[indexPath.row]
                cell.lblTitle.text = object.text
                cell.action = object.redirectTo ?? onboardingViewModel.currentStep.rawValue
                cell.btnOption.addTarget(self, action: #selector(onButtonTap(sender:)), for: .touchUpInside)
                return cell
            case .rightTextView:
                let cell = tableView.dequeueReusableCell(withClass: RightTextViewCell.self)
                cell.selectionStyle = .none
                let object = self.arrChatContent[indexPath.row]
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                return cell
            default:
                break
            }
        case .optNotificationNo:
            let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
            cell.selectionStyle = .none
            cell.lblText.text = object.text
            cell.lblTime.text = object.time
            self.postOnboardingProgress(data: [:], displayData: "")
            return cell
        case .optNotificationSlotSetUp:
            let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
            cell.selectionStyle = .none
            cell.lblText.text = object.text
            cell.lblTime.text = object.time
            self.postOnboardingProgress(data: [:], displayData: "")
            return cell
        case .personalizeContent:
            let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
            cell.selectionStyle = .none
            cell.lblText.text = object.text
            cell.lblTime.text = object.time
            self.postOnboardingProgress(data: [:], displayData: "")
            return cell
        case .personalizeContentSetup:
            switch object.type {
            case .personalizeContentSetup:
                let cell = tableView.dequeueReusableCell(withClass: LeftImageWithTextCell.self)
                cell.selectionStyle = .none
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                self.postOnboardingProgress(data: [:], displayData: "")
                return cell
            default:
               break
            }
        case .letsBegin:
            switch object.type {
            case .personalizeContentSetup:
                let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                cell.selectionStyle = .none
                cell.lblText.text = object.text
                cell.lblTime.text = object.time
                self.postOnboardingProgress(data: [:], displayData: "")
                return cell
            case .button:
                let cell = tableView.dequeueReusableCell(withClass: RightButtonCell.self)
                cell.selectionStyle = .none
                let object = self.arrChatContent[indexPath.row]
                cell.lblTitle.text = object.text
                cell.action = object.redirectTo ?? onboardingViewModel.currentStep.rawValue
                cell.btnOption.addTarget(self, action: #selector(onButtonTap(sender:)), for: .touchUpInside)
                return cell
            default:
               break
            }
    default:
        break;
        
    }
    /* switch object.type {
     case .typing:
     let cell = tableView.dequeueReusableCell(withClass: TypingCell.self)
     cell.selectionStyle = .none
     cell.startAnimation()
     return cell
     case .letsBegin:
     let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
     cell.selectionStyle = .none
     
     let object = self.arrChatContent[indexPath.row]
     if object.text.contains("Now, let me show you around") {
     //self.onboardingViewModel.currentStep = .letsBegin
     //  self.postOnboardingProgress(data: [:], displayData: "")
     cell.lblText.text = object.text
     }
     
     cell.lblText.text = object.text
     cell.lblTime.text = object.time
     return cell
     case .textView:
     let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
     cell.selectionStyle = .none
     
     let object = self.arrChatContent[indexPath.row]
     if object.text.lowercased().contains("hello david this font") {
     let fontSize: CGFloat = CGFloat(UserDefaults.prefFontSize)
     cell.lblText.text = object.text + " \(UserDefaults.prefFontSize)"
     cell.changeFontSize(size: fontSize)
     }
     
     /* if self.onboardingViewModel.currentStep == .typeOneDiabetesSelect &&  object.text == "Just so you know, I am only designed to assist people with type 2 diabetes. The advice presented will not be applicable to people with type 1 diabetes. Please keep this in mind if you decide to continue using this app." {
      self.postOnboardingProgress(data: [:], displayData: "")
      cell.lblText.text = object.text
      cell.lblTime.text = object.time
      }
      if object.text.contains("Perhaps you could talk to your doctor about diabetes distress next time you see him") {
      self.postOnboardingProgress(data: [:], displayData: "")
      cell.lblText.text = object.text
      cell.lblTime.text = object.time
      }*/
     else {
     cell.lblText.text = object.text
     cell.lblTime.text = object.time
     }
     cell.lblText.text = object.text
     cell.lblTime.text = object.time
     
     
     return cell
     case .optNotificationSlotSetUp:
     let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
     cell.selectionStyle = .none
     let object = self.arrChatContent[indexPath.row]
     cell.lblText.text = object.text
     cell.lblTime.text = object.time
     
     if object.text.contains("Ok, I'll send you notifications at your chosen time of day.") {
     
     self.onboardingViewModel.currentStep = .personalizeContent
     self.postOnboardingProgress(data: [:], displayData: "")
     
     }
     
     case .personalizeContent:
     let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
     cell.selectionStyle = .none
     let object = self.arrChatContent[indexPath.row]
     cell.lblText.text = object.text
     cell.lblTime.text = object.time
     if object.text.contains("Give me a moment while I personalize your content...") {
     // cell.lblText.text = object.text
     self.onboardingViewModel.currentStep = .personalizeContentSetup
     self.postOnboardingProgress(data: [:], displayData: "")
     
     }
     
     
     case .optNotificationNo:
     let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
     cell.selectionStyle = .none
     let object = self.arrChatContent[indexPath.row]
     cell.lblText.text = object.text
     cell.lblTime.text = object.time
     if object.text.contains("I get it. Just so you know, the app might not be as helpful as designed without notifications.") {
     
     self.onboardingViewModel.currentStep = .personalizeContent
     self.postOnboardingProgress(data: [:], displayData: "")
     //  cell.lblText.text = object.text
     
     cell.lblText.text = object.text
     cell.lblTime.text = object.time
     }
     
     //        case .typeOneDiabetesSelect:
     //            let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
     //            cell.selectionStyle = .none
     //            let object = self.arrChatContent[indexPath.row]
     //
     //            cell.lblText.text = object.text
     //            cell.lblTime.text = object.time
     //            self.onboardingViewModel.currentStep = .typeOneDiabetesSelect
     //            self.postOnboardingProgress(data: [:], displayData: "")
     ////            if object.text.contains("Just so you know, I am only designed to assist people with type 2 diabetes. The advice presented will not be applicable to people with type 1 diabetes. Please keep this in mind if you decide to continue using this app.") {
     ////                cell.lblText.text = object.text
     ////                self.onboardingViewModel.currentStep = .typeOneDiabetesSelect
     ////                self.postOnboardingProgress(data: [:], displayData: "")
     ////                //cell.lblText.text = object.text
     ////            }
     
     
     
     case .learningInterestScaleLess :
     let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
     cell.selectionStyle = .none
     let object = self.arrChatContent[indexPath.row]
     
     cell.lblText.text = object.text
     cell.lblTime.text = object.time
     if object.text.contains("Perhaps you could talk to your doctor about diabetes distress next time you see him") {
     
     self.onboardingViewModel.currentStep = .improvementChangeSelect
     self.postOnboardingProgress(data: [:], displayData: "")
     cell.lblText.text = object.text
     cell.lblTime.text = object.time
     
     }
     return cell
     
     case .learningInterestScaleMore :
     let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
     cell.selectionStyle = .none
     let object = self.arrChatContent[indexPath.row]
     cell.lblText.text = object.text
     cell.lblTime.text = object.time
     self.onboardingViewModel.currentStep = .improvementChangeSelect
     self.postOnboardingProgress(data: [:], displayData: "")
     return cell
     
     case .personalizeContentSetup :
     
     let object = self.arrChatContent[indexPath.row]
     if object.text.contains("Personalization complete") {
     let cell = tableView.dequeueReusableCell(withClass: LeftImageWithTextCell.self)
     cell.selectionStyle = .none
     cell.lblText.text = object.text
     cell.lblTime.text = object.time
     
     self.onboardingViewModel.currentStep = .letsBegin
     self.postOnboardingProgress(data: [:], displayData: "")
     
     return cell
     }
     if object.text.contains("Now, let me show you around") {
     let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
     cell.selectionStyle = .none
     cell.lblText.text = object.text
     cell.lblTime.text = object.time
     return cell
     }
     
     
     case .rightTextView:
     let cell = tableView.dequeueReusableCell(withClass: RightTextViewCell.self)
     cell.selectionStyle = .none
     let object = self.arrChatContent[indexPath.row]
     cell.lblText.text = object.text
     cell.lblTime.text = object.time
     return cell
     
     case .button:
     let cell = tableView.dequeueReusableCell(withClass: RightButtonCell.self)
     cell.selectionStyle = .none
     let object = self.arrChatContent[indexPath.row]
     cell.lblTitle.text = object.text
     cell.action = object.redirectTo ?? onboardingViewModel.currentStep.rawValue
     cell.btnOption.addTarget(self, action: #selector(onButtonTap(sender:)), for: .touchUpInside)
     return cell
     case .studyNumber:
     let cell = tableView.dequeueReusableCell(withClass: StudyNumberTableViewCell.self)
     // cell.tag = 0
     cell.selectionStyle = .none
     //  cell.lblAge.text = "Study Number"
     cell.studyNumberTextField.text = ""
     // cell.btnSubmit.tag = indexPath.row
     cell.submitButton.addTarget(self, action: #selector(onStudyNumberSubmit(sender:)), for: .touchUpInside)
     return cell
     
     case .signUpForm:
     let cell = tableView.dequeueReusableCell(withClass: CreateAccountCell.self)
     cell.selectionStyle = .none
     cell.btnSubmit.addTarget(self, action: #selector(onCreateAccountSubmit(sender:)), for: .touchUpInside)
     return cell
     case .imageWithText:
     let cell = tableView.dequeueReusableCell(withClass: LeftImageWithTextCell.self)
     cell.selectionStyle = .none
     let object = self.arrChatContent[indexPath.row]
     cell.lblText.text = object.text
     cell.lblTime.text = object.time
     return cell
     case .mobileVerify:
     let cell = tableView.dequeueReusableCell(withClass: MobileVerifyCell.self)
     cell.selectionStyle = .none
     cell.btnSubmit.tag = indexPath.row
     cell.btnSubmit.addTarget(self, action: #selector(onMobileVerifySubmit(sender:)), for: .touchUpInside)
     return cell
     case .otpVerify:
     let cell = tableView.dequeueReusableCell(withClass: OTPVerifyCell.self)
     cell.selectionStyle = .none
     cell.btnSubmit.tag = indexPath.row
     cell.btnSubmit.addTarget(self, action: #selector(onOTPVerifySubmit(sender:)), for: .touchUpInside)
     cell.btnResendOTP.tag = indexPath.row
     cell.btnResendOTP.addTarget(self, action: #selector(onBtnResentTap(sender:)), for: .touchUpInside)
     return cell
     case .fullName:
     let cell = tableView.dequeueReusableCell(withClass: EmailVerifyCell.self)
     cell.tag = 0
     cell.selectionStyle = .none
     cell.lblEmail.text = "Full Name"
     cell.txtEmail.text = ""
     cell.btnSubmit.tag = indexPath.row
     cell.btnSubmit.addTarget(self, action: #selector(onFullNameSubmit(sender:)), for: .touchUpInside)
     return cell
     case .calledName:
     let cell = tableView.dequeueReusableCell(withClass: EmailVerifyCell.self)
     cell.tag = 1
     cell.selectionStyle = .none
     cell.lblEmail.text = ""
     cell.txtEmail.text = ""
     cell.btnSubmit.tag = indexPath.row
     cell.btnSubmit.addTarget(self, action: #selector(onFullNameSubmit(sender:)), for: .touchUpInside)
     return cell
     case .inputDOB:
     let cell = tableView.dequeueReusableCell(withClass: AgeCell.self)
     cell.tag = 1
     cell.lblAge.text = ""
     cell.txtAge.text = ""
     cell.selectionStyle = .none
     cell.btnSubmit.tag = indexPath.row
     cell.btnSubmit.addTarget(self, action: #selector(onAgeSubmit(sender:)), for: .touchUpInside)
     return cell
     case .genderSelection:
     let cell = tableView.dequeueReusableCell(withClass: genderSelectCell.self)
     //            var gender = ["Male", "Female", "Others"]
     //            cell.selectionStyle = .none
     //            cell.lblTitle.text = gender[indexPath.row]
     //
     // cell.btnOption.addTarget(self, action: #selector(onBtnGenderSelection(sender:)), for: .touchUpInside)
     cell.maleButton.tag = 1
     cell.maleButton.addTarget(self, action: #selector(onBtnGenderSelection(sender:)), for: .touchUpInside)
     cell.femaleButton.tag = 2
     cell.femaleButton.addTarget(self, action: #selector(onBtnGenderSelection(sender:)), for: .touchUpInside)
     cell.othersButton.tag = 3
     cell.othersButton.addTarget(self, action: #selector(onBtnGenderSelection(sender:)), for: .touchUpInside)
     return cell
     case .diabetesDiscoverySelect :
     let cell = tableView.dequeueReusableCell(withClass: AgeCell.self)
     cell.tag = 2
     cell.selectionStyle = .none
     cell.lblAge.text = ""
     cell.txtAge.text = ""
     cell.btnSubmit.tag = indexPath.row
     cell.btnSubmit.addTarget(self, action: #selector(ondiabetesDiscoverySelect(sender:)), for: .touchUpInside)
     return cell
     case .datePicker:
     let cell = tableView.dequeueReusableCell(withClass: DatePickerCell.self)
     cell.selectionStyle = .none
     cell.btnSubmit.tag = indexPath.row
     cell.btnSubmit.addTarget(self, action: #selector(onBirthDateSelection(sender:)), for: .touchUpInside)
     return cell
     case .slider:
     let cell = tableView.dequeueReusableCell(withClass: SliderCell.self)
     cell.selectionStyle = .none
     cell.slider.isContinuous = false
     cell.action = object.redirectTo
     cell.slider.tag = indexPath.row
     cell.slider.addTarget(self, action: #selector(onSliderValueChange(sender:)), for: .valueChanged)
     return cell
     
     case .personalProgram:
     break
     case .login:
     let cell = tableView.dequeueReusableCell(withClass: LoginCell.self)
     cell.selectionStyle = .none
     cell.btnForgotPassword.addTarget(self, action: #selector(onForgotPasswordTap(sender:)), for: .touchUpInside)
     cell.btnLoginToAccount.addTarget(self, action: #selector(onLoginTap(sender:)), for: .touchUpInside)
     return cell
     case .forgotPassword:
     let cell = tableView.dequeueReusableCell(withClass: ForgotPasswordCell.self)
     cell.selectionStyle = .none
     cell.btnResetLink.addTarget(self, action: #selector(onPasswordResetTap(sender:)), for: UIControl.Event.touchUpInside)
     return cell
     case .readingFontSize:
     let cell = tableView.dequeueReusableCell(withClass: ReadingFontSizeCell.self)
     cell.selectionStyle = .none
     cell.btnFont14.tag = 14
     cell.btnFont14.addTarget(self, action: #selector(onReadingFontSizeSelection(sender:)), for: .touchUpInside)
     cell.btnFont16.tag = 16
     cell.btnFont16.addTarget(self, action: #selector(onReadingFontSizeSelection(sender:)), for: .touchUpInside)
     cell.btnFont18.tag = 18
     cell.btnFont18.addTarget(self, action: #selector(onReadingFontSizeSelection(sender:)), for: .touchUpInside)
     cell.btnFont20.tag = 20
     cell.btnFont20.addTarget(self, action: #selector(onReadingFontSizeSelection(sender:)), for: .touchUpInside)
     return cell
     case .none:
     return UITableViewCell()
     
     }*/
    return UITableViewCell()
}
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.dismiss(animated: true)
}
}

// MARK: - OnboardingChatbotDelegate
extension OnboardingChatbotViewController: OnboardingChatbotDelegate {
    
    func showError(message: String) {
        self.showErrorToast(message)
    }
    
    func onSetupSteps(arrContent: [chatContent], arrOptions: [chatContent]) {
        self.messageIndex = 0
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            guard arrContent.count > self.messageIndex else {
                timer.invalidate()
                self.arrChatContent.append(contentsOf: arrOptions)
                
                self.reloadAndScrollToBottom()
                return
            }
            self.showTyping()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.hideTyping()
                self.arrChatContent.append(arrContent[self.messageIndex])
                self.reloadAndScrollToBottom()
                self.messageIndex += 1
            }
        }
    }
}

// MARK: - Chat bot cell button actions
extension OnboardingChatbotViewController {
    
    @IBAction func onReadingFontSizeSelection(sender: UIButton) {
        let fontSize = sender.tag
        let selectedFont = sender.tag == 14 ? "14 - Hello David" : sender.tag == 16 ? "16 - Hello David" : sender.tag == 18 ? "18 - Hello David" : "20 - Hello David"
        self.onFontSizeSelection(fontSize: selectedFont, size: fontSize)
    }
    
    @objc func onButtonTap(sender: UIButton) {
        if let cell = sender.superview?.superview?.superview as? RightButtonCell {
            if let action = cell.action {
                switch action {
                case "themeSelect".Chatbotlocalized():
                    let selectedTheme = (cell.lblTitle.text ?? "".Chatbotlocalized()).lowercased()
                    UserDefaults.theme = selectedTheme
                    (UIApplication.shared.delegate as? AppDelegate)?.changeUserInterfaceStyle(for: selectedTheme)
                    self.postOnboardingProgress(data: ["value":selectedTheme], displayData: selectedTheme.capitalized)
                case "fontPreview":
                    Glow.sharedInstance.prefFontSize = UserDefaults.prefFontSize
                    self.postOnboardingProgress(data: [:], displayData: "Looks Good")
                    //
                    //                case "studyNumber":
                    //                    self.removeOptions()
                    //                    self.arrChatContent.append(("studyNumber".Chatbotlocalized(), ChatbotCell.rightTextView, nil, nil))
                    //                    self.showStartTyping {
                    //                        self.onboardingViewModel.currentStep = .studyNumber
                    //                        self.arrChatContent.append(("", ChatbotCell.studyNumber, nil, nil))
                    //                        self.reloadAndScrollToBottom()
                    //                    }
                case "createAccount":
                    self.removeOptions()
                    // self.arrChatContent.append(("Create an account".Chatbotlocalized(), ChatbotCell.rightTextView, nil, nil))
                    self.reloadAndScrollToBottom()
                    self.showStartTyping {
                        self.onboardingViewModel.currentStep = .createAccount
                        // self.arrChatContent.append(("", ChatbotCell.signUpForm, nil, nil))
                        self.reloadAndScrollToBottom()
                    }
                case "login":
                    self.removeOptions()
                    // self.arrChatContent.append(("Login".Chatbotlocalized(), ChatbotCell.rightTextView, nil, nil))
                    self.reloadAndScrollToBottom()
                    self.showStartTyping {
                        self.onboardingViewModel.currentStep = .login
                        // self.arrChatContent.append(("", ChatbotCell.login, nil, nil))
                        self.reloadAndScrollToBottom()
                    }
                    //                case "genderSelect":
                    //                    let text = cell.lblTitle.text ?? ""
                    //                    self.ongenderSelection(option: text)
                case "futureSignInOpt":
                    let text = cell.lblTitle.text ?? ""
                    UserDefaults.futureSignInOpt = text
                    self.onFutureSignInSelection(option: text)
                case "ethniticySelect":
                    let text = cell.lblTitle.text ?? ""
                    self.onEthniticySelection(option: text)
                case "describeYourself":
                    let text = cell.lblTitle.text ?? ""
                    self.ondescribeYourselfSelection(option: text)
                    //                case "typeOneDiabetesSelect":
                    //                    self.postOnboardingProgress(data: [:], displayData: "")
                case "optNotification":
                    let text = cell.lblTitle.text ?? ""
                    self.onNotificationSelection(option: text)
                case "optNotificationYes":
                    let text = cell.lblTitle.text ?? ""
                    self.onNotificationSelectionYes(option: text)
                case "optNotificationNo":
                    let text = cell.lblTitle.text ?? ""
                    self.onNotificationSelectionNo(option: text)
                    
                case "inputPatientName":
                    let text = cell.lblTitle.text ?? ""
                    self.onPatientNameSelect(option: text)
                    
                case "diabetesDiscoverySelect":
                    let text = cell.lblTitle.text ?? ""
                    self.onPatientNameSelect(option: text)
                case "learningInterestScale":
                    let text = cell.lblTitle.text ?? ""
                    self.onlearnininInterestScaleMoreSelect()
                case "learningInterestScaleMore":
                    let text = cell.lblTitle.text ?? ""
                    self.onlearnininInterestScaleMoreSelect()
                case "letsBegin":
                    // let text = cell.lblTitle.text ?? ""
                    self.onlestBeginTapSelect()
                case "diabetesTypeSelect":
                    let text = cell.lblTitle.text ?? ""
                    self.onDiabetesTypeSelection(option: text)
                case "diabetesConditionSelect":
                    let text = cell.lblTitle.text ?? ""
                    self.onDiabetesConditionSelection(option: text)
                case "studyGoalSelect":
                    let text = cell.lblTitle.text ?? ""
                    self.onStudyGoalSelection(option: text)
                case "improvementChangeSelect":
                    let text = cell.lblTitle.text ?? ""
                    self.onImprovementChangeSelection(option: text)
                case "diabeticChildrenChancesSelect":
                    let text = cell.lblTitle.text ?? ""
                    self.onDiabeticChildChanceSelection(option: text)
                default:
                    break
                }
            }
        }
    }
    
    @objc private func onForgotPasswordTap(sender: UIButton) {
        
        self.removeOptions()
        //self.arrChatContent.append(("Did you forgot your password? Enter the email and a reset password link will sent to your registered email.".Chatbotlocalized(), ChatbotCell.textView, nil, nil))
        self.reloadAndScrollToBottom()
        self.showStartTyping {
            self.onboardingViewModel.currentStep = .forgotPassword
            //  self.arrChatContent.append(("", ChatbotCell.forgotPassword, nil, nil))
            self.reloadAndScrollToBottom()
        }
    }
    
    @objc private func onPasswordResetTap(sender: UIButton) {
        
        if let forgotPasswordCell = sender.superview?.superview?.superview?.superview?.superview as? ForgotPasswordCell {
            
            let txtEmail = forgotPasswordCell.txtEmail.text ?? ""
            let errorMessage = onboardingViewModel.validateForgotPassword(email: txtEmail)
            if let errMessage = errorMessage {
                self.showErrorToast(errMessage)
            } else {
                ProgressHUD.show()
                self.loginViewModel.email = txtEmail
                self.loginViewModel.forgotPassword { isSuccess, error in
                    ProgressHUD.dismiss()
                    DispatchQueue.main.async {
                        if isSuccess {
                            if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: LoginViewController.identifier) as? LoginViewController {
                                self.navigationController?.pushViewController(loginVC, animated: true)
                            }
                        } else {
                            self.showErrorToast(error)
                            self.alertMessage(title: error ?? "Oops!Something went wrong")
                        }
                    }
                }
            }
        }
    }
    
    @objc private func onLoginTap(sender: UIButton) {
        
        if let loginCell = sender.superview?.superview?.superview?.superview?.superview as? LoginCell {
            
            let txtEmail = loginCell.txtEmail.text ?? ""
            let txtPassword = loginCell.txtPassword.text ?? ""
            
            let errorMessage = onboardingViewModel.validateSignIn(email: txtEmail, password: txtPassword)
            if let errMessage = errorMessage {
                self.showErrorToast(errMessage)
            } else {
                let dict = ["email": txtEmail, "password": txtPassword]
                self.postOnboardingProgress(data: dict, displayData: "Email: \(txtEmail)\nPassword: ****************")
            }
        }
    }
    
    @objc private func onStudyNumberSubmit(sender: UIButton) {
        
        if let studyNumCell =  sender.superview?.superview?.superview?.superview?.superview  as? StudyNumberTableViewCell {
            
            let studyNumber = studyNumCell.studyNumberTextField.text ?? ""
            let dict = ["studyNumber": studyNumber, "font": Glow.sharedInstance.prefFontSize, "theme": UserDefaults.theme,"futureSignInOpt":UserDefaults.futureSignInOpt ] as [String : Any]
            self.postOnboardingProgress(data: dict, displayData: "\(studyNumber)")
            // studyNumCell.txtAge.text = nil
            
        }
        
        /*  if let cell = self.tblChatboat.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? AgeCell {
         if cell.tag == 0 {
         guard let studyNumber = cell.txtAge.text, !studyNumber.trimWhiteSpace.isEmpty else {
         self.self.showErrorToast("Please enter Study Number".Chatbotlocalized())
         return
         }
         let dict = ["studyNumber": studyNumber, "font": Glow.sharedInstance.prefFontSize, "theme": UserDefaults.theme,"futureSignInOpt":UserDefaults.futureSignInOpt ] as [String : Any]
         self.postOnboardingProgress(data: ["studyNumber":dict], displayData: studyNumber)
         }
         if cell.tag == 1 {
         if let cell = self.tblChatboat.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? AgeCell {
         guard let ageNumber = cell.txtAge.text, !ageNumber.trimWhiteSpace.isEmpty else {
         self.self.showErrorToast("Please enter age".Chatbotlocalized())
         return
         }
         self.postOnboardingProgress(data: ["value":ageNumber], displayData: ageNumber)
         }
         }
         else {
         if let cell = self.tblChatboat.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? AgeCell {
         guard let careTakerAge = cell.txtAge.text, !careTakerAge.trimWhiteSpace.isEmpty else {
         self.self.showErrorToast("Please enter age".Chatbotlocalized())
         return
         }
         self.postOnboardingProgress(data: ["value":careTakerAge], displayData: ageNumber)
         }
         
         
         }
         }*/
        
    }
    
    @objc private func ondiabetesDiscoverySelect(sender: UIButton) {
        
        if let discoveryCell = self.tblChatboat.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? AgeCell {
            let age = discoveryCell.txtAge.text ?? ""
            let dict = ["value": age]
            
            self.postOnboardingProgress(data: dict, displayData: "\(age)")
        }
        
    }
    @objc private func onCreateAccountSubmit(sender: UIButton) {
        
        if let createAccCell = sender.superview?.superview?.superview?.superview?.superview as? CreateAccountCell {
            
            let txtEmail = createAccCell.txtUserName.text ?? ""
            let txtPassword = createAccCell.txtPassword.text ?? ""
            let txtRepeatPassword = createAccCell.txtRepeatPassword.text ?? ""
            
            let errorMessage = onboardingViewModel.validateSignUp(email: txtEmail, password: txtPassword, repeatPassword: txtRepeatPassword)
            if let errMessage = errorMessage {
                self.showErrorToast(errMessage)
            } else {
                let dict = ["email": txtEmail, "password": txtPassword]
                self.postOnboardingProgress(data: dict, displayData: "Email: \(txtEmail)\nPassword: ****************")
            }
        }
    }
    
    @objc private func onMobileVerifySubmit(sender: UIButton) {
        
        if let cell = self.tblChatboat.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? MobileVerifyCell {
            let mobileNo = "\(cell.lblCountryCode.text ?? "")\(cell.txtMobile.text ?? "")"
            if let error = onboardingViewModel.validatePhoneNo(phoneNo: mobileNo) {
                self.self.showErrorToast(error)
                return
            }
            UserDefaults.phoneNo = mobileNo
            self.postOnboardingProgress(data: ["phoneNumber": mobileNo], displayData: "Mobile number:\n\(mobileNo)")
        }
    }
    
    @IBAction func onOTPVerifySubmit(sender: UIButton) {
        
        if let cell = self.tblChatboat.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? OTPVerifyCell {
            guard let otp1 = cell.txtOTP1.text,
                  let otp2 = cell.txtOTP2.text,
                  let otp3 = cell.txtOTP3.text,
                  let otp4 = cell.txtOTP4.text,
                  let otp5 = cell.txtOTP5.text,
                  let otp6 = cell.txtOTP6.text,
                  !otp1.trimWhiteSpace.isEmpty, !otp2.trimWhiteSpace.isEmpty, !otp3.trimWhiteSpace.isEmpty, !otp4.trimWhiteSpace.isEmpty, !otp5.trimWhiteSpace.isEmpty, !otp6.trimWhiteSpace.isEmpty else {
                self.self.showErrorToast("Please enter OTP".Chatbotlocalized())
                return
            }
            let phoneNo = UserDefaults.phoneNo ?? "+918866797969"
            let otp = "\(otp1)\(otp2)\(otp3)\(otp4)\(otp5)\(otp6)"
            let dict = ["phoneNumber": phoneNo, "otp": otp]
            self.postOnboardingProgress(data: dict, displayData: "OTP:\n\(otp)")
        }
    }
    
    @objc private func onBtnResentTap(sender: UIButton) {
        guard let phoneNo = UserDefaults.phoneNo else {
            return
        }
        ProgressHUD.show()
        loginViewModel.phoneNo = phoneNo
        loginViewModel.resendOTP { isSuccess, error in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                    self.showSuccessToast("OTP send".Chatbotlocalized())
                } else {
                    self.showErrorToast(error)
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
    
    @objc private func onFutureSignInSelection(option: String) {
        
        
        self.postOnboardingProgress(data: ["value": option], displayData: option)
    }
    
    @objc private func onFutureStudyNumberSelection(option: String) {
        
        self.postOnboardingProgress(data: ["value": option], displayData: option)
    }
    @objc private func ongenderSelection(option: String) {
        
        self.postOnboardingProgress(data: ["value": option], displayData: option)
    }
    
    @objc private func onPatientNameSelect(option: String) {
        
        self.postOnboardingProgress(data: ["value": option], displayData: option)
    }
    @objc private func onNotificationSelection(option: String) {
        self.onboardingViewModel.currentStep = .optNotification
        self.postOnboardingProgress(data: ["value": option], displayData: option)
    }
    @objc private func onNotificationSelectionYes(option: String) {
        // self.onboardingViewModel.currentStep = .optNotificationYes
        
        self.postOnboardingProgress(data: ["value": option], displayData: option)
    }
    @objc private func onNotificationSelectionNo(option: String) {
        self.onboardingViewModel.currentStep = .optNotificationNo
        self.postOnboardingProgress(data: ["value": option], displayData: option)
        //        self.onboardingViewModel.currentStep = .personalizeContent
        //        self.postOnboardingProgress(data: ["value": option], displayData: option)
    }
    
    
    @objc private func onFullNameSubmit(sender: UIButton) {
        
        if let cell = self.tblChatboat.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? EmailVerifyCell {
            if cell.tag == 0 {
                guard let txtFullName = cell.txtEmail.text, !txtFullName.trimWhiteSpace.isEmpty else {
                    self.self.showErrorToast("Please enter full name".Chatbotlocalized())
                    return
                }
                self.postOnboardingProgress(data: ["fullName":txtFullName], displayData: txtFullName)
            } else {
                if let cell = self.tblChatboat.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? EmailVerifyCell {
                    guard let txtNickName = cell.txtEmail.text, !txtNickName.trimWhiteSpace.isEmpty else {
                        self.self.showErrorToast("Please enter name".Chatbotlocalized())
                        return
                    }
                    self.postOnboardingProgress(data: ["value":txtNickName], displayData: txtNickName)
                }
            }
        }
    }
    
    @objc private func onAgeSubmit(sender: UIButton) {
        
        if let cell =  self.tblChatboat.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as?  AgeCell {
            
            guard let txtAge = cell.txtAge.text,  !txtAge.trimWhiteSpace.isEmpty else {
                self.showErrorToast("Please enter age".Chatbotlocalized())
                return
            }
            self.postOnboardingProgress(data: ["value":txtAge], displayData: txtAge)
            
        }
    }
    
    @objc private func onBtnGenderSelection(sender: UIButton) {
        
        let selectedGender = sender.tag == 1 ? "Male".Chatbotlocalized() : sender.tag == 2 ? "Female".Chatbotlocalized() : "Others".Chatbotlocalized()
        self.postOnboardingProgress(data: ["value": selectedGender], displayData: selectedGender)
    }
    
    @objc private func onEthniticySelection(option: String) {
        
        self.postOnboardingProgress(data: ["value": option], displayData: option)
    }
    @objc private func ondescribeYourselfSelection(option: String) {
        
        self.postOnboardingProgress(data: ["value": option], displayData: option)
        
    }
    @objc private func ontypeOneDiabetesSelect() {
        // self.onboardingViewModel.currentStep = .describeYourself
        self.postOnboardingProgress(data: [:], displayData: "")
        
    }
    
    
    @objc private func onlestBeginTapSelect() {
        let login = AppStoryboard.onboardingChatbot.viewController(viewcontrollerClass: LoginViewController.self)
        
        self.navigationController?.pushViewController(login, animated: true)
    }
    @objc private func onBirthDateSelection(sender: UIButton) {
        
        if let cell = self.tblChatboat.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? DatePickerCell {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            let displayDate = dateFormatter.string(from: cell.datePicker.date)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let selectedDate = dateFormatter.string(from: cell.datePicker.date)
            self.postOnboardingProgress(data: ["value": selectedDate], displayData: displayDate)
        }
    }
    
    @objc private func onDiabetesTypeSelection(option: String) {
        
        self.postOnboardingProgress(data: ["value": option], displayData: option)
    }
    
    @objc private func onDiabetesConditionSelection(option: String) {
        
        self.postOnboardingProgress(data: ["value": option], displayData: option)
    }
    
    @objc private func onStudyGoalSelection(option: String) {
        
        self.postOnboardingProgress(data: ["value": option], displayData: option)
    }
    
    @objc private func onImprovementChangeSelection(option: String) {
        self.onboardingViewModel.currentStep = .improvementChangeSelect
        
        self.postOnboardingProgress(data: ["value": option], displayData: option)
    }
    
    @objc private func onlearnininInterestScaleMoreSelect() {
        
        self.postOnboardingProgress(data: [:], displayData: "")
        //  self.onboardingViewModel.loadNextStep(object: Onboarding[Step])
        
    }
    
    @IBAction func onSliderValueChange(sender: UISlider) {
        if let cell = self.tblChatboat.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? SliderCell {
            let value = "\(Int(cell.slider.value))"
            if let _ = cell.action {
                self.postOnboardingProgress(data: ["value": value], displayData: value)
            }
            
            
            
        }
    }
    
    @objc private func onDiabeticChildChanceSelection(option: String) {
        self.postOnboardingProgress(data: ["value": option], displayData: option)
    }
    
    private func onFontSizeSelection(fontSize: String, size: Int) {
        UserDefaults.prefFontSize = size
        self.postOnboardingProgress(data: ["value":"\(size)"], displayData: fontSize)
    }
}
