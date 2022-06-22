//
//  DynamicChatbotViewController.swift
//  Glow
//
//  Created by Pushpa Yadav on 26/11/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit
import ProgressHUD

class DynamicChatbotViewController: UIViewController {
    
    static let identifier = "DynamicChatbotViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var vwNavigation: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var vwOnline: UIView!
    @IBOutlet weak var lblOnline: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var vwSearch: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var tblChatboat: UITableView!
    
    @IBOutlet weak var displaySearch: UILabel!
    // MARK: - Variables
    var botId: String?
    var arrUnits = [Unit]()
    var objUnit: Unit?
    var status: String?
    var timer = Timer()
    private let chatbotViewModel = ChatbotViewModel()
    
    
    private var messageIndex = 0
    private var arrBotResponse = [(type: BotOptionType, message: StepMessage?, option: [StepOption]?, setting: StepSetting?, time: String?, value: String?, stepResponseMessage: StepResponseMessages?, status: String?)]()
    private var searchIndex = 0
    private var arrSearchResult = [(type: BotOptionType, message: StepMessage?, option: [StepOption]?, setting: StepSetting?, time: String?, value: String?, stepResponseMessage: StepResponseMessages?, status: String?)]()
    private var optionStartTime: Date?
    private var optionEndTime: Date?
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decorateUI()
        registerTableCell()
        getPreviousSteps()
        
        
        print("Any", self.arrBotResponse)
        //  getFAQQuestionList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        //        self.status = chatbotViewModel.botstatus
        //        print(self.status)
    }
    
    
    
    
    // MARK: - Private methods
    private func decorateUI() {
        
        lblTitle.setUp(title: "Glow".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .AppColors.blackText, noOfLine: 1)
        lblOnline.setUp(title: "Online".Chatbotlocalized(), font: UIFont.Poppins.regular.size(FontSize.subtitle_12), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
        
        vwOnline.layer.cornerRadius = vwOnline.frame.height/2
        vwOnline.clipsToBounds = true
        
        txtSearch.addTarget(self, action: #selector(onSearch(textField:)), for: .editingChanged)
        displaySearch.isHidden = true
        btnBack.setUpBlank()
        btnSearch.setUpBlank()
        btnNext.setUpBlank()
        btnNext.setImage(UIImage(named: "dropdown"), for: .normal)
        btnPrev.setUpBlank()
        btnPrev.setImage(UIImage(named: "dropdown"), for: .normal)
        btnPrev.transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    private func registerTableCell() {
        
        self.tblChatboat.delegate = self
        self.tblChatboat.dataSource = self
        self.tblChatboat.separatorStyle = .none
        
        self.tblChatboat.register(nibWithCellClass: TypingCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: MCQCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: YesNoCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: TextNumberInputCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: TextWithImageCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: TextWithVideoCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: DatePickerCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: LeftTextViewCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: RightTextViewCell.self, at: nil)
        self.tblChatboat.register(nibWithCellClass: SliderCell.self, at: nil)
    }
    
    private func reloadAndScrollToBottom() {
        self.tblChatboat.reloadData()
        guard !self.arrBotResponse.isEmpty else { return }
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.arrBotResponse.count-1, section: 0)
            self.tblChatboat.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    private func showTypingFor(_ miliseconds: Int = 1000, completion: @escaping ()->()) {
        self.arrBotResponse.append((type: BotOptionType.typing, message: nil, option: nil, setting: nil, time: nil, value: nil, stepResponseMessage: nil,status: self.status))
        self.reloadAndScrollToBottom()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(miliseconds)) {
            self.arrBotResponse.removeLast()
            self.reloadAndScrollToBottom()
            completion()
        }
    }
    
    private func loadPreviousChatbotStep(objPreviousSteps: PreviousStepResponse?) {
        
        guard let objPreviousSteps = objPreviousSteps, let arrPrevSteps = objPreviousSteps.prevSteps else {
            return
        }
        for object in arrPrevSteps {
            for objMessage in object.stepMessages ?? [] {
                let type = BotOptionType(rawValue: objMessage.type ?? "") ?? .shortText
                self.arrBotResponse.append((type: type, message: objMessage, option: nil, setting: nil, time: Date().toString(format: "h:mm a"), value: nil, stepResponseMessage: nil, status: self.status))
            }
            if let response = object.response {
                var value: String? = response.textValue
                if let numVal = response.numberValue, value == nil {
                    value = "\(numVal)"
                } else if let stepOptionId = response.stepOptionId, value == nil {
                    value = (object.stepOptions ?? []).filter({$0.id == stepOptionId}).first?.text
                } else if let dateVal = response.dateValue, value == nil {
                    value = dateVal
                }
                if value != nil {
                    self.arrBotResponse.append((type: BotOptionType.rightTextView, message: nil, option: [], setting: nil, time: Date().toString(format: "h:mm a"), value: value, stepResponseMessage: nil, status: self.status))
                }
            }
            if let objStepResponse = object.stepResponse {
                if let arrStepMessage = objStepResponse.stepResponseMessages {
                    for object in arrStepMessage {
                        self.arrBotResponse.append((type: BotOptionType.textView, message: nil, option: [], setting: nil, time: Date().toString(format: "h:mm a"), value: nil, stepResponseMessage: object, status: self.status))
                    }
                }
            }
        }
        self.reloadAndScrollToBottom()
        self.getCurrentStep(isRepeat: true)
    }
    
    private func loadCurrentChatbotStep(isRepeat: Bool) {
        if !isRepeat {
            if let prevStep = self.chatbotViewModel.previousStep, let response = prevStep.response {
                var value: String? = response.textValue
                if let numVal = response.numberValue, value == nil {
                    value = "\(numVal)"
                } else if let stepOptionId = response.stepOptionId, value == nil {
                    value = (prevStep.stepOptions ?? []).filter({$0.id == stepOptionId}).first?.text
                } else if let dateVal = response.dateValue, value == nil {
                    value = dateVal
                }
                if value != nil {
                    self.arrBotResponse.append((type: BotOptionType.rightTextView, message: nil, option: [], setting: nil, time: Date().toString(format: "h:mm a"), value: value, stepResponseMessage: nil, status: self.status))
                    self.reloadAndScrollToBottom()
                }
            }
            if let objStepResponse = self.chatbotViewModel.previousStep?.stepResponse {
                if let arrStepMessage = objStepResponse.stepResponseMessages {
                    for object in arrStepMessage {
                        self.arrBotResponse.append((type: BotOptionType.textView, message: nil, option: [], setting: nil, time: Date().toString(format: "h:mm a"), value: nil, stepResponseMessage: object, status: self.status))
                    }
                    self.reloadAndScrollToBottom()
                }
            }
        }
        guard let currentStep = self.chatbotViewModel.currentStep else {
            return
        }
      
        let type = BotOptionType(rawValue: currentStep.type ?? "") ?? .shortText
        let arrMessages = self.chatbotViewModel.currentStep?.stepMessages ?? []
        
        if arrMessages.count <= self.messageIndex {
            self.arrBotResponse.append((type: type, message: nil, option: currentStep.stepOptions, setting: currentStep.stepSettings, time: Date().toString(format: "h:mm a"), value: nil, stepResponseMessage: nil, status: self.status))
            self.reloadAndScrollToBottom()
            self.optionStartTime = Date()
            return
        } else {
            let arrMessages = (currentStep.stepMessages ?? []).sorted(by: {$0.position ?? 0 < $1.position ?? 0})
            let delay = arrMessages[self.messageIndex].delay ?? 2000
            self.showTypingFor(delay) {
                self.arrBotResponse.append((type: type, message: arrMessages[self.messageIndex], option: nil, setting: nil, time: Date().toString(format: "h:mm a"), value: nil, stepResponseMessage: nil, status: self.status))
                self.reloadAndScrollToBottom()
                self.messageIndex += 1
                self.loadCurrentChatbotStep(isRepeat: true)
            }
        }
        if self.chatbotViewModel.currentStep == nil  {
           
        }
    }
    
    private func removeLastStepOption() {
        if let object = self.arrBotResponse.last, object.type != .typing {
            self.arrBotResponse.removeLast()
        }
    }
    
    // MARK: - Actions
    @IBAction func onBtnSearch_Tap(sender: UIButton) {
        vwSearch.isHidden = !vwSearch.isHidden
        txtSearch.text = nil
        if vwSearch.isHidden {
            searchIndex = 0
            arrSearchResult = []
        }
    }
    
    @objc func onSearch(textField: UITextField) {
        if let searchText = textField.text, !searchText.isEmpty {
            self.arrSearchResult = self.arrBotResponse.filter { objectTuple in
                return (objectTuple.stepResponseMessage?.text ?? "").contains(searchText) ||
                (objectTuple.value ?? "").contains(searchText) || (objectTuple.message?.text ?? "").contains(searchText) }
            if self.arrSearchResult.isEmpty {
                // searchActive = false;
                displaySearch.isHidden = false
            }
            if !self.arrSearchResult.isEmpty {
                displaySearch.isHidden = true
                let object = self.arrSearchResult[searchIndex]
                if let index = self.arrBotResponse.firstIndex(where: { objectTuple in
                    return (objectTuple.stepResponseMessage?.text ?? "").contains(object.stepResponseMessage?.text ?? "") ||
                    (objectTuple.value ?? "").contains(object.value ?? "") ||
                    (objectTuple.message?.text ?? "").contains(object.message?.text ?? "")
                }) {
                    self.tblChatboat.scrollToRow(at: IndexPath(row: index, section: 0), at: .none, animated: true)
                }
            }
            //            if let index = self.arrBotResponse.firstIndex(where: { objectTuple in
            //                return (objectTuple.stepResponseMessage?.text ?? "").contains(searchText) ||
            //                (objectTuple.value ?? "").contains(searchText) ||
            //                (objectTuple.message?.text ?? "").contains(searchText)
            //            }) {
            //                self.tblChatboat.scrollToRow(at: IndexPath(row: index, section: 0), at: .none, animated: true)
            //            }
        }
    }
    
    @IBAction func onBtnNextClick(sender: UIButton) {
        if self.arrSearchResult.count > self.searchIndex + 1 {
            searchIndex += 1
            let object = self.arrSearchResult[searchIndex]
            if let index = self.arrBotResponse.firstIndex(where: { objectTuple in
                return (objectTuple.stepResponseMessage?.text ?? "").contains(object.stepResponseMessage?.text ?? "") ||
                (objectTuple.value ?? "").contains(object.value ?? "") ||
                (objectTuple.message?.text ?? "").contains(object.message?.text ?? "")
            }) {
                self.tblChatboat.scrollToRow(at: IndexPath(row: index, section: 0), at: .none, animated: true)
            }
        }
    }
    
    @IBAction func onBtnPrevClick(sender: UIButton) {
        searchIndex -= 1
        if self.searchIndex > 0 {
            let object = self.arrSearchResult[searchIndex]
            if let index = self.arrBotResponse.firstIndex(where: { objectTuple in
                return (objectTuple.stepResponseMessage?.text ?? "").contains(object.stepResponseMessage?.text ?? "") ||
                (objectTuple.value ?? "").contains(object.value ?? "") ||
                (objectTuple.message?.text ?? "").contains(object.message?.text ?? "")
            }) {
                self.tblChatboat.scrollToRow(at: IndexPath(row: index, section: 0), at: .none, animated: true)
            }
        }
    }
    
    // MARK: - API Calls
    private func getPreviousSteps() {
        ProgressHUD.show()
        chatbotViewModel.chatbotId = self.botId
        // chatbotViewModel.getPreviousStep(completion: <#T##(Bool, String?, PreviousStepResponse?) -> ()#>)
        chatbotViewModel.getPreviousStep { isSuccess, errMessage, objPreviousRes in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                    self.loadPreviousChatbotStep(objPreviousSteps: objPreviousRes)
                } else {
                    //                    self.showErrorToast(errMessage)
                    self.alertMessage(title: errMessage ?? "Oops!Something went wrong")
                }
            }
        }
    }
    
    private func getCurrentStep(isRepeat: Bool, isShowLoader: Bool = true) {
        if isShowLoader {
            ProgressHUD.show()
        }
        chatbotViewModel.chatbotId = self.botId
        // chatbotViewModel.getCurrentStep(completion: <#T##(Bool, String?, ChatbotResponse?) -> ()#>)
        chatbotViewModel.getCurrentStep { isSuccess, errMessage, chatBotRes in
            if isShowLoader {
                ProgressHUD.dismiss()
            }
            DispatchQueue.main.async {
                if isSuccess {
                    self.messageIndex = 0
                    self.status = chatBotRes?.status
                  
                    self.loadCurrentChatbotStep(isRepeat: isRepeat)
                    
                } else {
                    //                    self.showErrorToast(errMessage)
                    self.alertMessage(title: errMessage ?? "Oops!Something went wrong")
                }
            }
        }
    }
    
    private func postCurrentStepData(value: String, timeTaken: Int) {
        //        ProgressHUD.show()
        chatbotViewModel.timeTaken = Int(timeTaken)
        chatbotViewModel.value = value
        chatbotViewModel.postStepData { isSuccess, error in
            //            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                    self.removeLastStepOption()
                    self.getCurrentStep(isRepeat: false, isShowLoader: false)
                } else {
                    // self.showErrorToast(error)
                    self.alertMessage(title: error ?? "Oops!Something went wrong")
                }
            }
        }
    }
    
    // MARK: - Cell button actions
    @IBAction func onBtnBack() {
        super.onBtnBackTap()
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
extension DynamicChatbotViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrBotResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = self.arrBotResponse[indexPath.row]
    
        if object.type == .typing {
            let cell = tableView.dequeueReusableCell(withClass: TypingCell.self)
            cell.selectionStyle = .none
            cell.startAnimation()
            return cell
        } else {
            if let message = object.message {
                let messageType = BotMessageType(rawValue: message.type ?? "") ?? .text
                switch messageType {
                case .text:
                    let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                    cell.selectionStyle = .none
                    cell.lblText.text = message.text
                    cell.lblTime.text = object.time
                    return cell
                case .image:
                    let cell = tableView.dequeueReusableCell(withClass: TextWithImageCell.self)
                    cell.object = object.message
                    cell.lblTime.text = object.time
                    return cell
                case .video:
                    let cell = tableView.dequeueReusableCell(withClass: TextWithVideoCell.self)
                    cell.object = object.message
                    cell.lblTime.text = object.time
                    return cell
                case .link:
                    let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                    cell.selectionStyle = .none
                    cell.lblText.text = message.text
                    cell.lblTime.text = object.time
                    return cell
                case .educationLesson:
                    let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                    cell.selectionStyle = .none
                    cell.lblText.text = message.text
                    cell.lblTime.text = object.time
                    return cell
                case .Bot:
                    let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                    cell.selectionStyle = .none
                    cell.lblText.text = message.text
                    cell.lblTime.text = object.time
                    return cell
                }
            }
            else {
                let botOption = object.type
                switch botOption {
                case .multipleChoice:
                    let cell = tableView.dequeueReusableCell(withClass: MCQCell.self)
                    cell.delegate = self
                    cell.arrOptions = object.option
                    cell.layoutIfNeeded()
                    cell.tblOption.reloadData()
                    cell.tblOption.layoutSubviews()
                    //                    cell.nslcTblHeight.constant = cell.tblOption.contentSize.height
                    return cell
                case .shortText, .longText, .number:
                    let cell = tableView.dequeueReusableCell(withClass: TextNumberInputCell.self)
                    cell.txtInput.text = ""
                    cell.btnSubmit.tag = indexPath.row
                    cell.btnSubmit.addTarget(self, action: #selector(onBtnSubmit(sender:)), for: .touchUpInside)
                    cell.isNumber = botOption == .number
                    return cell
                case .yesNo:
                    let cell = tableView.dequeueReusableCell(withClass: YesNoCell.self)
                    cell.arrOptions = object.option
                    cell.btnYes.tag = indexPath.row
                    cell.btnYes.addTarget(self, action: #selector(onBtnYesNoTap(sender:)), for: .touchUpInside)
                    cell.btnNo.tag = indexPath.row
                    cell.btnNo.addTarget(self, action: #selector(onBtnYesNoTap(sender:)), for: .touchUpInside)
                    return cell
                case .calendar:
                    let cell = tableView.dequeueReusableCell(withClass: DatePickerCell.self)
                    cell.selectionStyle = .none
                    cell.btnSubmit.tag = indexPath.row
                    cell.btnSubmit.addTarget(self, action: #selector(onCalendarSubmit(sender:)), for: .touchUpInside)
                    return cell
                case .slider:
                    let cell = tableView.dequeueReusableCell(withClass: SliderCell.self)
                    cell.selectionStyle = .none
                    cell.objSetting = object.setting
                    cell.slider.tag = indexPath.row
                    cell.slider.addTarget(self, action: #selector(onSliderValueChange(sender:)), for: .valueChanged)
                    return cell
                case .textView:
                    //let cell = tableView.dequeueReusableCell(withClass: RightTextViewCell.self)
                    let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                    cell.selectionStyle = .none
                    cell.delegate = self
                    cell.lblText.text = object.value
                    cell.lblTime.text = object.time
                    cell.objStepResponseMsg = object.stepResponseMessage
                    return cell
                case .rightTextView:
                    let cell = tableView.dequeueReusableCell(withClass: RightTextViewCell.self)
                    cell.selectionStyle = .none
                    cell.lblText.text = object.value
                    cell.lblTime.text = object.time
                    return cell
                default:
                    return UITableViewCell()
                }
            }
        }
        
        //        if indexPath.row == self.arrBotResponse.count {
        //                //call method asynchronously to indicate table finished loading
        //            self.showSuccessToast("Bots Completed")
        //            }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)  {
        
        let topicSB = UIStoryboard(name: "Topics", bundle: nil)
        let objectRes = self.arrBotResponse[indexPath.row]
        if objectRes.status == "completed" {
            print("completed")
            if let cell = cell as? LeftTextViewCell {
                                    cell.lblText.text = "This conversation ended"
                                    cell.lblTime.text = Date().toString(format: "h:mm a")
                //                    cell.lblText.text = "Go to Unit"
                //                    cell.lblTime.text = Date().toString(format: "h:mm a")
            
                                }
           // timer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
        }
        
//        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
//            if indexPath == lastVisibleIndexPath {
//             //  let array = ["This conversation ended", "Go to Unit"]
//                if objectRes.status == "completed" {
//                    if let cell = cell as? LeftTextViewCell {
//                        cell.lblText.text = "This conversation ended"
//                        cell.lblTime.text = Date().toString(format: "h:mm a")
//    //                    cell.lblText.text = "Go to Unit"
//    //                    cell.lblTime.text = Date().toString(format: "h:mm a")
//
//                    }
//
//                }
//
//
//
//
//            }
//        }
     

    }
    /*
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath >= lastVisibleIndexPath  {
//                if objectRes.status == "completed" {
//                    var cell:LeftTextViewCell = cell as! LeftTextViewCell
//                    cell.lblText.text = "This conversation ended"
//                    cell.lblTime.text = Date().toString(format: "h:mm a")
//                }
            
               
            }
        }
      
        

    }
    */
    @objc func timerAction() {
        self.dismiss(animated: true)
    }
}

// MARK: - TextViewDelegate
extension DynamicChatbotViewController: TextViewDelegate {
    func moveToWebPage(link: String) {
        //
    }
    
    
    func moveToEducationLesson(educationLesson: BotEducationLesson) {
        let topicsVC = TopicsViewController.instantiateFromAppStoryBoard(appStoryBoard: .topics)
        topicsVC.hidesBottomBarWhenPushed = true
        topicsVC.lessonsViewModel.lessonId = educationLesson.id
        self.navigationController?.pushViewController(topicsVC, animated: true)
    }
    
    func moveToUnit(lesson: BotEducationLesson, unit: Unit) {
        let topicSB = UIStoryboard(name: "Topics", bundle: nil)
        if let webVC = topicSB.instantiateViewController(withIdentifier: WebViewController.identifier) as? WebViewController {
            webVC.objUnit = unit
            self.navigationController?.pushViewController(webVC, animated: true)
        }
    }
    
    func moveToUnitPage(lesson: BotEducationLesson, unit: Unit, page: EducationLessonPage) {
        let topicSB = UIStoryboard(name: "Topics", bundle: nil)
        if let webVC = topicSB.instantiateViewController(withIdentifier: WebViewController.identifier) as? WebViewController {
            webVC.objUnit = unit
            webVC.pageId = page.id
            self.navigationController?.pushViewController(webVC, animated: true)
        }
    }
    
    
    @IBAction func onBtnSubmit(sender: UIButton) {
        if let cell = self.tblChatboat.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? TextNumberInputCell, let value = cell.txtInput.text {
            self.optionEndTime = Date()
            if let startTime = self.optionStartTime, let endTime = self.optionEndTime {
                let timeTaken = Int(endTime.timeIntervalSince(startTime) * 1000)
                self.postCurrentStepData(value: value, timeTaken: timeTaken)
            }
        }
    }
    
    @IBAction func onBtnYesNoTap(sender: UIButton) {
        if let cell = self.tblChatboat.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? YesNoCell,
           let options = cell.arrOptions {
            self.optionEndTime = Date()
            if let startTime = self.optionStartTime, let endTime = self.optionEndTime {
                let timeTaken = Int(endTime.timeIntervalSince(startTime) * 1000)
                let yesNo = sender.titleLabel?.text == "yes" ? "yes" : "no"
                let value = options.filter({$0.text == yesNo}).first?.id ?? ""
                self.postCurrentStepData(value: value, timeTaken: timeTaken)
            }
        }
    }
    
    @IBAction func onCalendarSubmit(sender: UIButton) {
        if let cell = self.tblChatboat.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? DatePickerCell {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let selectedDate = dateFormatter.string(from: cell.datePicker.date)
            
            self.optionEndTime = Date()
            if let startTime = self.optionStartTime, let endTime = self.optionEndTime {
                let timeTaken = Int(endTime.timeIntervalSince(startTime) * 1000)
                self.postCurrentStepData(value: selectedDate, timeTaken: timeTaken)
            }
        }
    }
    
    @IBAction func onSliderValueChange(sender: UISlider) {
        if let cell = self.tblChatboat.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? SliderCell {
            let value = "\(Int(cell.slider.value))"
            
            self.optionEndTime = Date()
            if let startTime = self.optionStartTime, let endTime = self.optionEndTime {
                let timeTaken = Int(endTime.timeIntervalSince(startTime) * 1000)
                self.postCurrentStepData(value: value, timeTaken: timeTaken)
            }
        }
    }
}

// MARK: - MCQDelegate
extension DynamicChatbotViewController: MCQDelegate {
    func onFAQObjSelect(object: Options?) {
        //
    }
    

    func onObjectSelection(object: StepOption?) {
        self.optionEndTime = Date()
        if let startTime = self.optionStartTime, let endTime = self.optionEndTime {
            let timeTaken = Int(endTime.timeIntervalSince(startTime) * 1000)
            if let value = object?.id {
                self.postCurrentStepData(value: value, timeTaken: timeTaken)
            }
        }
    }
}
