//
//  OnboardingStepThreeViewController.swift
//  Glow
//
//  Created by Pushpa Yadav on 26/11/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class OnboardingStepThreeViewController: UIViewController {
    
    static let identifier = "OnboardingStepThreeViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var vwNavigation: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var vwOnline: UIView!
    @IBOutlet weak var lblOnline: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnSetting: UIButton!
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var tblChatboat: UITableView!
    
    // MARK: - Variables
    let onboardingViewModel = OnboardingChatbotViewModel()
    var arrChatbotCell: [ChatbotCell] = []
    var arrChatContent: [(strMessage: String?, showProfile: Bool, time: String?, optionTag: Int?)] = []
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decorateUI()
        registerTableCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Private methods
    private func decorateUI() {
        
        lblTitle.setUp(title: "Glow".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.blackText, noOfLine: 1)
        lblOnline.setUp(title: "Online".Chatbotlocalized(), font: UIFont.Poppins.regular.size(FontSize.subtitle_12), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
        
        vwOnline.layer.cornerRadius = vwOnline.frame.height/2
        vwOnline.clipsToBounds = true
        
        btnBack.setUpBlank()
        btnSearch.setUpBlank()
        btnSetting.setUpBlank()
    }
    
    private func registerTableCell() {
        
        self.tblChatboat.delegate = self
        self.tblChatboat.dataSource = self
        self.tblChatboat.separatorStyle = .none
        
        self.tblChatboat.register(nibWithCellClass: TypingCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: GenderSelectionCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: DatePickerCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: LeftTextViewCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: RightButtonCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: RightTextViewCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: SliderCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: LeftPersonalProgramCell.self, at: nil)
    }
    
    private func reloadAndScrollToBottom() {
        self.tblChatboat.reloadData()
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.arrChatbotCell.count-1, section: 0)
            self.tblChatboat.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    
//    private func onGenderSelection(selectedGender: String) {
//
//        self.arrChatbotCell.removeLast()
//        self.arrChatContent.removeLast()
//
//        self.arrChatbotCell.append(.RightTextView)
//        self.arrChatContent.append((strMessage: selectedGender, showProfile: false, time: Date().toString(format: "h:mm a"), optionTag: nil))
//        self.reloadAndScrollToBottom()
//
//        self.showStartTyping {
//            self.arrChatbotCell.append(.TextView)
//            self.arrChatContent.append((strMessage: self.onboardingViewModel.strEthnicity, showProfile: true, time: Date().toString(format: "h:mm a"), optionTag: nil))
//            self.onboardingViewModel.arrEthnicity.forEach { object in
//                self.arrChatbotCell.append(.ButtonOption)
//                self.arrChatContent.append((strMessage: object.title, showProfile: false, time: nil, optionTag: object.tag))
//            }
//            self.reloadAndScrollToBottom()
//        }
//    }
    
//    private func onEthnicitySelection(selectedEthnicity: String) {
//        for cellType in self.arrChatbotCell.reversed() {
//            if cellType == .ButtonOption {
//                self.arrChatbotCell.removeLast()
//                self.arrChatContent.removeLast()
//            } else {
//                break
//            }
//        }
//        self.arrChatbotCell.append(.RightTextView)
//        self.arrChatContent.append((strMessage: selectedEthnicity, showProfile: false, time: Date().toString(format: "h:mm a"), optionTag: nil))
//        self.reloadAndScrollToBottom()
//
//        self.showStartTyping {
//            self.arrChatbotCell.append(.TextView)
//            self.arrChatContent.append((strMessage: self.onboardingViewModel.strBirthDate, showProfile: true, time: Date().toString(format: "h:mm a"), optionTag: nil))
//            self.arrChatbotCell.append(.DatePicker)
//            self.arrChatContent.append((strMessage: nil, showProfile: false, time: nil, optionTag: nil))
//            self.reloadAndScrollToBottom()
//        }
//    }

    
//    private func onStartStepthreee(){
//
//        showStartTyping {
//
//            self.arrChatbotCell.append(.TextView)
//            self.arrChatContent.append((strMessage: self.onboardingViewModel.strDiabetesInfo, showProfile: false, time: Date().toString(format: "h:mm a"), optionTag: nil))
//            self.reloadAndScrollToBottom()
//
//            self.showStartTyping {
//                self.arrChatbotCell.append(.TextView)
//                self.arrChatContent.append((strMessage: self.onboardingViewModel.strDiabetesType, showProfile: true, time: Date().toString(format: "h:mm a"), optionTag: nil))
//                self.onboardingViewModel.arrDiabetesType.forEach { object in
//                    self.arrChatbotCell.append(.ButtonOption)
//                    self.arrChatContent.append((strMessage: object.title, showProfile: false, time: nil, optionTag: object.tag))
//                }
//                self.reloadAndScrollToBottom()
//            }
//        }
//    }
    
//    private func onDiabtesTypeSelection(selectedDiabetes: String) {
//        for cellType in self.arrChatbotCell.reversed() {
//            if cellType == .ButtonOption {
//                self.arrChatbotCell.removeLast()
//                self.arrChatContent.removeLast()
//            } else {
//                break
//            }
//        }
//        self.arrChatbotCell.append(.RightTextView)
//        self.arrChatContent.append((strMessage: selectedDiabetes, showProfile: false, time: Date().toString(format: "h:mm a"), optionTag: nil))
//        self.reloadAndScrollToBottom()
//
//        self.showStartTyping {
//            self.arrChatbotCell.append(.TextView)
//            self.arrChatContent.append((strMessage: self.onboardingViewModel.strCondition, showProfile: true, time: Date().toString(format: "h:mm a"), optionTag: nil))
//            self.onboardingViewModel.arrConditions.forEach { object in
//                self.arrChatbotCell.append(.ButtonOption)
//                self.arrChatContent.append((strMessage: object.title, showProfile: false, time: nil, optionTag: object.tag))
//            }
//            self.reloadAndScrollToBottom()
//        }
//    }
    
//    private func onConditionSelection(selectedCondition: String) {
//        for cellType in self.arrChatbotCell.reversed() {
//            if cellType == .ButtonOption {
//                self.arrChatbotCell.removeLast()
//                self.arrChatContent.removeLast()
//            } else {
//                break
//            }
//        }
//        self.arrChatbotCell.append(.RightTextView)
//        self.arrChatContent.append((strMessage: selectedCondition, showProfile: false, time: Date().toString(format: "h:mm a"), optionTag: nil))
//        self.reloadAndScrollToBottom()
//
//        self.showStartTyping {
//            self.arrChatbotCell.append(.TextView)
//            self.arrChatContent.append((strMessage: self.onboardingViewModel.strDiabetesAge, showProfile: true, time: Date().toString(format: "h:mm a"), optionTag: nil))
//            self.onboardingViewModel.arrDiabetesAge.forEach { object in
//                self.arrChatbotCell.append(.ButtonOption)
//                self.arrChatContent.append((strMessage: object.title, showProfile: false, time: nil, optionTag: object.tag))
//            }
//            self.reloadAndScrollToBottom()
//        }
//    }
    
//    private func onWhatAgeDiabetesSelection(selectedAge: String) {
//        for cellType in self.arrChatbotCell.reversed() {
//            if cellType == .ButtonOption {
//                self.arrChatbotCell.removeLast()
//                self.arrChatContent.removeLast()
//            } else {
//                break
//            }
//        }
//        self.arrChatbotCell.append(.RightTextView)
//        self.arrChatContent.append((strMessage: selectedAge, showProfile: false, time: Date().toString(format: "h:mm a"), optionTag: nil))
//        self.reloadAndScrollToBottom()
//
//        self.showStartTyping {
//            self.arrChatbotCell.append(.TextView)
//            self.arrChatContent.append((strMessage: self.onboardingViewModel.strDiabetesStatus, showProfile: false, time: Date().toString(format: "h:mm a"), optionTag: nil))
//            self.reloadAndScrollToBottom()
//
//            self.showStartTyping {
//                self.arrChatbotCell.append(.TextView)
//                self.arrChatContent.append((strMessage: self.onboardingViewModel.strParticipationGoal, showProfile: true, time: Date().toString(format: "h:mm a"), optionTag: nil))
//                self.onboardingViewModel.arrParticipationGoal.forEach { object in
//                    self.arrChatbotCell.append(.ButtonOption)
//                    self.arrChatContent.append((strMessage: object.title, showProfile: false, time: nil, optionTag: object.tag))
//                }
//                self.reloadAndScrollToBottom()
//            }
//        }
//    }
    
//    private func onMainGoalSelection(selectedGoal: String) {
//        for cellType in self.arrChatbotCell.reversed() {
//            if cellType == .ButtonOption {
//                self.arrChatbotCell.removeLast()
//                self.arrChatContent.removeLast()
//            } else {
//                break
//            }
//        }
//        self.arrChatbotCell.append(.RightTextView)
//        self.arrChatContent.append((strMessage: selectedGoal, showProfile: false, time: Date().toString(format: "h:mm a"), optionTag: nil))
//        self.reloadAndScrollToBottom()
//
//        self.showStartTyping {
//            self.arrChatbotCell.append(.TextView)
//            self.arrChatContent.append((strMessage: self.onboardingViewModel.strChangeToImprove, showProfile: true, time: Date().toString(format: "h:mm a"), optionTag: nil))
//            self.onboardingViewModel.arrChangeToImprove.forEach { object in
//                self.arrChatbotCell.append(.ButtonOption)
//                self.arrChatContent.append((strMessage: object.title, showProfile: false, time: nil, optionTag: object.tag))
//            }
//            self.reloadAndScrollToBottom()
//        }
//    }
    
//    private func onSingleChangeImproveSelection(selectedChange: String) {
//        for cellType in self.arrChatbotCell.reversed() {
//            if cellType == .ButtonOption {
//                self.arrChatbotCell.removeLast()
//                self.arrChatContent.removeLast()
//            } else {
//                break
//            }
//        }
//        self.arrChatbotCell.append(.RightTextView)
//        self.arrChatContent.append((strMessage: selectedChange, showProfile: false, time: Date().toString(format: "h:mm a"), optionTag: nil))
//        self.reloadAndScrollToBottom()
//
//        self.showStartTyping {
//            self.arrChatbotCell.append(.TextView)
//            self.arrChatContent.append((strMessage: self.onboardingViewModel.strSelfManagement, showProfile: true, time: Date().toString(format: "h:mm a"), optionTag: nil))
//            self.arrChatbotCell.append(.Slider)
//            self.arrChatContent.append((strMessage: nil, showProfile: false, time: nil, optionTag: ButtonTag.ScaleSelfManagement.rawValue))
//            self.reloadAndScrollToBottom()
//        }
//    }
    
//    private func onHowReadyToLearnSelection(howReady: Int) {
//        self.arrChatbotCell.removeLast()
//        self.arrChatContent.removeLast()
//
//        self.arrChatbotCell.append(.RightTextView)
//        self.arrChatContent.append((strMessage: "\(howReady)", showProfile: false, time: Date().toString(format: "h:mm a"), optionTag: nil))
//        self.reloadAndScrollToBottom()
//
//        self.showStartTyping {
//            self.arrChatbotCell.append(.TextView)
//            self.arrChatContent.append((strMessage: self.onboardingViewModel.strHowReady, showProfile: true, time: Date().toString(format: "h:mm a"), optionTag: nil))
//            self.arrChatbotCell.append(.Slider)
//            self.arrChatContent.append((strMessage: nil, showProfile: false, time: nil, optionTag: ButtonTag.HowReady.rawValue))
//            self.reloadAndScrollToBottom()
//        }
//    }
    
//    private func onInterestedToImproveSelection(howReady: Int) {
//        self.arrChatbotCell.removeLast()
//        self.arrChatContent.removeLast()
//
//        self.arrChatbotCell.append(.RightTextView)
//        self.arrChatContent.append((strMessage: "\(howReady)", showProfile: false, time: Date().toString(format: "h:mm a"), optionTag: nil))
//        self.reloadAndScrollToBottom()
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.onStartStepFour()
//        }
//    }
    
//    private func onStartStepFour() {
//
//        self.arrChatbotCell.removeAll()
//        self.arrChatContent.removeAll()
//
//        self.showStartTyping {
//            self.arrChatbotCell.append(.TextView)
//            self.arrChatContent.append((strMessage: self.onboardingViewModel.strAlmostThere, showProfile: false, time: Date().toString(format: "h:mm a"), optionTag: nil))
//            self.reloadAndScrollToBottom()
//
//            self.showStartTyping {
//                self.arrChatbotCell.append(.TextView)
//                self.arrChatContent.append((strMessage: self.onboardingViewModel.strTailorContent, showProfile: false, time: Date().toString(format: "h:mm a"), optionTag: nil))
//                self.reloadAndScrollToBottom()
//
//                self.showStartTyping {
//                    self.arrChatbotCell.append(.TextView)
//                    self.arrChatContent.append((strMessage: self.onboardingViewModel.strChildrenChance, showProfile: true, time: Date().toString(format: "h:mm a"), optionTag: nil))
//                    self.onboardingViewModel.arrChildrenChance.forEach { object in
//                        self.arrChatbotCell.append(.ButtonOption)
//                        self.arrChatContent.append((strMessage: object.title, showProfile: false, time: nil, optionTag: object.tag))
//                    }
//                    self.reloadAndScrollToBottom()
//                }
//            }
//        }
//    }
    
//    private func onHigherChangeToChildSelection(selectedChance: String) {
//        for cellType in self.arrChatbotCell.reversed() {
//            if cellType == .ButtonOption {
//                self.arrChatbotCell.removeLast()
//                self.arrChatContent.removeLast()
//            } else {
//                break
//            }
//        }
//        self.arrChatbotCell.append(.RightTextView)
//        self.arrChatContent.append((strMessage: selectedChance, showProfile: false, time: Date().toString(format: "h:mm a"), optionTag: nil))
//        self.reloadAndScrollToBottom()
//
//        self.showStartTyping {
//            self.arrChatbotCell.append(.PersonalProgram)
//            self.arrChatContent.append((strMessage: "", showProfile: true, time: Date().toString(format: "h:mm a"), optionTag: nil))
//            self.reloadAndScrollToBottom()
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
////                self.onStartStepFive()
//                let storyboard = UIStoryboard(name: "OnboardingChatbot", bundle: nil)
//                let initialViewController = storyboard.instantiateViewController(withIdentifier: MascotPersonViewController.identifier) as! MascotPersonViewController
//                initialViewController.mascotFor = .ThankYou
//                self.navigationController?.pushViewController(initialViewController, animated: true)
//            }
//        }
//    }
    
//    private func onStartStepFive() {
//
//        self.arrChatbotCell.removeAll()
//        self.arrChatContent.removeAll()
//
//        self.showStartTyping {
//            self.arrChatbotCell.append(.TextView)
//            self.arrChatContent.append((strMessage: "Choose a theme", showProfile: true, time: Date().toString(format: "h:mm a"), optionTag: nil))
//            ["Light", "Dark"].forEach { str in
//                self.arrChatbotCell.append(.ButtonOption)
//                self.arrChatContent.append((strMessage: str, showProfile: false, time: nil, optionTag: 100))
//            }
//            self.reloadAndScrollToBottom()
//        }
//    }
    
//    private func onThemeSelection(selectedTheme: String) {
//
//        for cellType in self.arrChatbotCell.reversed() {
//            if cellType == .ButtonOption {
//                self.arrChatbotCell.removeLast()
//                self.arrChatContent.removeLast()
//            } else {
//                break
//            }
//        }
//        self.arrChatbotCell.append(.RightTextView)
//        self.arrChatContent.append((strMessage: selectedTheme, showProfile: false, time: Date().toString(format: "h:mm a"), optionTag: nil))
//        self.reloadAndScrollToBottom()
//    }
    
    // MARK: - Cell button actions
    @IBAction func onBtnBack() {
        super.onBtnBackTap()
    }
    
    @IBAction func onBtnOption(sender: UIButton) {
//        if sender.tag == ButtonTag.Africa.rawValue || sender.tag == ButtonTag.America.rawValue || sender.tag == ButtonTag.Asia.rawValue || sender.tag == ButtonTag.Europe.rawValue || sender.tag == ButtonTag.MiddleEast.rawValue || sender.tag == ButtonTag.Oceania.rawValue {
//            let selectedEthnicity = sender.tag == ButtonTag.Africa.rawValue ? "Africa" : sender.tag == ButtonTag.America.rawValue ? "America" : sender.tag == ButtonTag.Asia.rawValue ? "Asia" : sender.tag == ButtonTag.Europe.rawValue ? "Europe" : sender.tag == ButtonTag.MiddleEast.rawValue ? "Middle East" : "Oceania"
//            self.onEthnicitySelection(selectedEthnicity: selectedEthnicity)
//        } else if sender.tag == ButtonTag.Type1.rawValue || sender.tag == ButtonTag.Type2.rawValue || sender.tag == ButtonTag.Gestational.rawValue {
//            let selectedDiabetes = sender.tag == ButtonTag.Type1.rawValue ? "Type 1" : sender.tag == ButtonTag.Type2.rawValue ? "Type 2" : "Gestational"
//            self.onDiabtesTypeSelection(selectedDiabetes: selectedDiabetes)
//        } else if sender.tag == ButtonTag.CoeliacDisease.rawValue || sender.tag == ButtonTag.DiabetesRetinopathy.rawValue || sender.tag == ButtonTag.DiabetesInsipidus.rawValue || sender.tag == ButtonTag.NecrobiosisLipoidicaDiabeticorum.rawValue {
//            let selectedDiabetes = sender.tag == ButtonTag.CoeliacDisease.rawValue ? "Coeliac disease" : sender.tag == ButtonTag.DiabetesRetinopathy.rawValue ? "Diabetes retinopathy" : sender.tag == ButtonTag.DiabetesInsipidus.rawValue ? "Diabetes insipidus" : "Necrobiosis lipoidica diabeticorum"
//            self.onConditionSelection(selectedCondition: selectedDiabetes)
//        } else if sender.tag == ButtonTag.Age26.rawValue || sender.tag == ButtonTag.Age27.rawValue || sender.tag == ButtonTag.Age28.rawValue || sender.tag == ButtonTag.Age29.rawValue {
//            let selectedAge = sender.tag == ButtonTag.Age26.rawValue ? "26" : sender.tag == ButtonTag.Age27.rawValue ? "27" : sender.tag == ButtonTag.Age28.rawValue ? "28" : "29"
//            self.onWhatAgeDiabetesSelection(selectedAge: selectedAge)
//        } else if sender.tag == ButtonTag.BeMoreActive.rawValue || sender.tag == ButtonTag.MakeBetterDietChoices.rawValue || sender.tag == ButtonTag.BetterManageMedications.rawValue || sender.tag == ButtonTag.LearnMoreAboutDiabetes.rawValue {
//            let selectedGoal = sender.tag == ButtonTag.BeMoreActive.rawValue ? "Be more active" : sender.tag == ButtonTag.MakeBetterDietChoices.rawValue ? "Make better diet choices" : sender.tag == ButtonTag.BetterManageMedications.rawValue ? "Better manage medications" : "Learn more about diabetes"
//            self.onMainGoalSelection(selectedGoal: selectedGoal)
//        } else if sender.tag == ButtonTag.MakeControl.rawValue || sender.tag == ButtonTag.MorePhysicalActivity.rawValue || sender.tag == ButtonTag.MoreMedication.rawValue || sender.tag == ButtonTag.MoreFocusAppointments.rawValue || sender.tag == ButtonTag.LessStress.rawValue || sender.tag == ButtonTag.Nothing.rawValue {
//            let selectedChange = sender.tag == ButtonTag.MakeControl.rawValue ? "Make control over healthy diet" : sender.tag == ButtonTag.MorePhysicalActivity.rawValue ? "More energy from physical activity" : sender.tag == ButtonTag.MoreMedication.rawValue ? "More adherence to medication" : sender.tag == ButtonTag.MoreFocusAppointments.rawValue ? "More focus on appointments" : sender.tag == ButtonTag.LessStress.rawValue ? "Less stress from diabetes" : "Nothing"
//            self.onSingleChangeImproveSelection(selectedChange: selectedChange)
//        } else if sender.tag == ButtonTag.Yes.rawValue || sender.tag == ButtonTag.No.rawValue || sender.tag == ButtonTag.DoNotKnow.rawValue {
//            let selectedChance = sender.tag == ButtonTag.Yes.rawValue ? "Yes" : sender.tag == ButtonTag.No.rawValue ? "No" : "I don’t know"
//            self.onHigherChangeToChildSelection(selectedChance: selectedChance)
//        }
    }
    
//    @IBAction func onBtnGenderSelection(sender: UIButton) {
//        let selectedGender = sender.tag == 1 ? "Male" : sender.tag == 2 ? "Female" : "Other"
//        if let cell = sender.superview?.superview?.superview?.superview?.superview as? GenderSelectionCell {
//            cell.selectGender(sender: sender)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                self.onGenderSelection(selectedGender: selectedGender)
//            }
//        }
//    }
    
//    @IBAction func onBtnImageSelectionTap(sender: UIButton) {
//        if let cell = sender.superview?.superview?.superview?.superview?.superview as? ImageSelectionCell {
//            cell.selectedOption = sender.tag
//        }
//    }
    
//    @IBAction func onBirthDateSelection(sender: UIButton) {
//        if let cell = sender.superview?.superview?.superview?.superview?.superview as? DatePickerCell {
//            let date = cell.datePicker.date
//            self.onBirthDateSelection(date: date)
//        }
//    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension OnboardingStepThreeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrChatbotCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatbotCell = self.arrChatbotCell[indexPath.row]
//        switch chatbotCell {
//        case .Typing:
//            let cell = tableView.dequeueReusableCell(withClass: TypingCell.self)
//            cell.selectionStyle = .none
//            cell.startAnimation()
//            return cell
//        case .TextView:
//            let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
//            cell.selectionStyle = .none
//            let object = self.arrChatContent[indexPath.row]
//            cell.lblText.text = object.strMessage
//            cell.imgView.isHidden = !object.showProfile
//            cell.lblTime.text = object.time
//            return cell
//        case .Gender:
//            let cell = tableView.dequeueReusableCell(withClass: GenderSelectionCell.self)
//            cell.selectionStyle = .none
//            cell.btnMale.tag = 1
//            cell.btnMale.addTarget(self, action: #selector(onBtnGenderSelection(sender:)), for: .touchUpInside)
//            cell.btnFemale.tag = 2
//            cell.btnFemale.addTarget(self, action: #selector(onBtnGenderSelection(sender:)), for: .touchUpInside)
//            cell.btnOther.tag = 3
//            cell.btnOther.addTarget(self, action: #selector(onBtnGenderSelection(sender:)), for: .touchUpInside)
//            return cell
//        case .DatePicker:
//            let cell = tableView.dequeueReusableCell(withClass: DatePickerCell.self)
//            cell.selectionStyle = .none
//            cell.btnSubmit.addTarget(self, action: #selector(onBirthDateSelection(sender:)), for: .touchUpInside)
//            return cell
//        case .ButtonOption:
//            let cell = tableView.dequeueReusableCell(withClass: RightButtonCell.self)
//            cell.selectionStyle = .none
//            let object = self.arrChatContent[indexPath.row]
//            cell.lblTitle.text = object.strMessage
//            cell.btnOption.tag = object.optionTag ?? 0
//            cell.btnOption.addTarget(self, action: #selector(onBtnOption(sender:)), for: .touchUpInside)
//            return cell
//        case .RightTextView:
//            let cell = tableView.dequeueReusableCell(withClass: RightTextViewCell.self)
//            cell.selectionStyle = .none
//            let object = self.arrChatContent[indexPath.row]
//            cell.lblText.text = object.strMessage
//            cell.lblTime.text = object.time
//            return cell
//        case .Slider:
//            let cell = tableView.dequeueReusableCell(withClass: SliderCell.self)
//            cell.selectionStyle = .none
//            cell.slider.isContinuous = false
//            cell.slider.tag = self.arrChatContent[indexPath.row].optionTag ?? 0
//            cell.slider.addTarget(self, action: #selector(onSliderValueChange(sender:)), for: .valueChanged)
//            return cell
//        case .PersonalProgram:
//            let cell = tableView.dequeueReusableCell(withClass: LeftPersonalProgramCell.self)
//            cell.selectionStyle = .none
//            let object = self.arrChatContent[indexPath.row]
//            cell.lblPercentage.text = "87%"
//            cell.lblTime.text = object.time
//            return cell
//        default:
//            return UITableViewCell()
//        }
        return UITableViewCell()
    }
}
