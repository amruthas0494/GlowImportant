//
//  FAQChatBotViewController.swift
//  Glow
//
//  Created by Cognitiveclouds on 03/06/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit
 import ProgressHUD

class FAQChatBotViewController: UIViewController {
    static let identifier = "FAQChatBotViewController"
    
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
  
    @IBOutlet weak var faqTableView: UITableView!
    
    @IBOutlet weak var displaySearch: UILabel!
    
    // MARK: - Variables
    var botId: String?
    var botStepId:String?
    private let faqViewModel = getFAQViewModel()
    private let chatBotViewModel  = ChatbotViewModel()
   
    
    private var messageIndex = 0
    private var arrBotResponse = [(type: BotOptionType, message: StepMessage?, option: [StepOption]?, setting: StepSetting?, time: String?, value: String?, stepResponseMessage: StepResponseMessages?)]()
    private var faqBotResponse = [(type: BotOptionType, message: BotMessage?, option: [Options]?, setting: StepSetting?, time: String?, value: String?, stepResponseMessage: StepResponseMessages?)]()
   // private var faqBotResponse = [(type: BotOptionType, message: StepMessage?, option: [StepOption]?, setting: StepSetting?, time: String?, value: String?, stepResponseMessage: StepResponseMessages?)]()
    private var searchIndex = 0
    private var arrSearchResult = [(type: BotOptionType, message: StepMessage?, option: [StepOption]?, setting: StepSetting?, time: String?, value: String?, stepResponseMessage: StepResponseMessages?)]()
   // private var faqBotResponse :PreviousStepResponse?
    private var optionStartTime: Date?
    private var optionEndTime: Date?
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decorateUI()
        registerTableCell()
        getallFAQSteps()
        //getCurrentStep(isRepeat: true, isShowLoader: true)
      //  print("Any", self.faqBotResponse)
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
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
        
        self.faqTableView.delegate = self
        self.faqTableView.dataSource = self
        self.faqTableView.separatorStyle = .none
        
        self.faqTableView.register(nibWithCellClass: TypingCell.self, at: nil)
        self.faqTableView.register(nibWithCellClass: LinkToWebCell.self, at: nil)
        self.faqTableView.register(nibWithCellClass: MCQCell.self, at: nil)
        self.faqTableView.register(nibWithCellClass: FAQMCQCell.self, at: nil)
        self.faqTableView.register(nibWithCellClass: YesNoCell.self, at: nil)
        self.faqTableView.register(nibWithCellClass: TextNumberInputCell.self, at: nil)
        self.faqTableView.register(nibWithCellClass: TextWithImageCell.self, at: nil)
        self.faqTableView.register(nibWithCellClass: TextWithVideoCell.self, at: nil)
        self.faqTableView.register(nibWithCellClass: DatePickerCell.self, at: nil)
        self.faqTableView.register(nibWithCellClass: LeftTextViewCell.self, at: nil)
        self.faqTableView.register(nibWithCellClass: RightTextViewCell.self, at: nil)
        self.faqTableView.register(nibWithCellClass: SliderCell.self, at: nil)
    }
    
    private func reloadAndScrollToBottom() {
        self.faqTableView.reloadData()
        guard !self.arrBotResponse.isEmpty else { return }
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.arrBotResponse.count-1, section: 0)
            self.faqTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    private func showTypingFor(_ miliseconds: Int = 1000, completion: @escaping ()->()) {
        self.arrBotResponse.append((type: BotOptionType.typing, message: nil, option: nil, setting: nil, time: nil, value: nil, stepResponseMessage: nil))
        self.reloadAndScrollToBottom()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(miliseconds)) {
            self.arrBotResponse.removeLast()
            self.reloadAndScrollToBottom()
            completion()
        }
    }
   /*
    private func loadPreviousChatbotStep(objPreviousSteps: CurrentStep?) {
        
        guard let objPreviousSteps = objPreviousSteps else {
            return
        }
      //  for object in arrPrevSteps {
            for objMessage in objPreviousSteps.botMessages ?? [] {
               // let type = BotOptionType(rawValue: botmessage.type ?? "") ?? .shortText
                let type = BotOptionType(rawValue: objMessage.type ?? "") ?? .shortText
                self.faqBotResponse.append((type: type, message: objMessage, option: nil, setting: nil, time: Date().toString(format: "h:mm a"), value: nil, stepResponseMessage: nil))
            }
            if let response = objPreviousSteps.response {
                var value: String? = response.textValue
                if let numVal = response.numberValue, value == nil {
                    value = "\(numVal)"
                } else if let stepOptionId = response.stepOptionId, value == nil {
                    value = (objPreviousSteps.options ?? []).filter({$0.id == stepOptionId}).first?.text
                } else if let dateVal = response.dateValue, value == nil {
                    value = dateVal
                }
                if value != nil {
                    self.faqBotResponse.append((type: BotOptionType.rightTextView, message: nil, option: [], setting: nil, time: Date().toString(format: "h:mm a"), value: value, stepResponseMessage: nil))
                }
            }
   
                for objResponses in objPreviousSteps.stepResponses   {
                   // let arrStepMessage = objResponses.stepResponseMessages
                   // if let arrStepMessage = eachResponse.stepResponseMessages ?? [] {
                        for objectResponse in  objResponses.stepResponseMessages ?? [] {
                           // self.faqBotResponse
                            self.faqBotResponse.append((type: BotOptionType.textView, message: nil, option: [], setting: nil, time: Date().toString(format: "h:mm a"), value: nil, stepResponseMessage: objectResponse))
                        }

                    }
                
          //  }
           //" }
//        }
        self.reloadAndScrollToBottom()
        self.getCurrentStep(botstepId: self.botStepId ?? "", isRepeat: true)
    }
        */
    
   
    private func loadPreviousChatbotStep(objPreviousSteps: CurrentStep?) {

//        guard let objPreviousSteps = objPreviousSteps else {
//            return
//        }
       
        for botmessage in objPreviousSteps?.botMessages ?? [] {
            //let type = BotMessageType(rawValue: botmessage.type ?? "") ?? .text
            let type = BotOptionType(rawValue: botmessage.type ?? "") ?? .shortText
            self.arrBotResponse.append((type: type, message: botmessage, option: nil, setting: nil, time: Date().toString(format: "h:mm a"), value:nil , stepResponseMessage: nil))
            print(self.arrBotResponse)

        }
        
        if let response = objPreviousSteps?.options {
            for eachOption in response {
                let type = BotOptionType(rawValue: objPreviousSteps?.type ?? "") ?? .rightTextView
                var value: String? = eachOption.text
                if value != nil {
                    self.arrBotResponse.append((type: type, message: nil, option: [eachOption], setting: nil, time: Date().toString(format: "h:mm a"), value: value, stepResponseMessage: nil))
                    print(self.arrBotResponse)

         
        }
            }
        }
//        if let objStepResponse = objPreviousSteps?.stepResponses {
//           
//           
//            for object in objStepResponse {
//                for stepresponses in object.stepResponseMessages ?? [] {
//                    self.arrBotResponse.append((type: BotOptionType.textView, message: nil, option: [], setting: nil, time: Date().toString(format: "h:mm a"), value: nil, stepResponseMessage: stepresponses))
//                }
//                   
//                }
//            //}
//        }
    
    self.reloadAndScrollToBottom()
        loadCurrentChatbotStep(isRepeat: true)
   // self.getCurrentStep(isRepeat: false)
    }
    
    
    private func loadCurrentChatbotStep(isRepeat: Bool ) {
        if !isRepeat {
            if let prevStep = self.chatBotViewModel.currentStep, let response = prevStep.response {
                var value: String? = response.textValue
                if let numVal = response.numberValue, value == nil {
                    value = "\(numVal)"
                } else if let stepOptionId = response.stepOptionId, value == nil {
                    value = (prevStep.stepOptions ?? []).filter({$0.id == stepOptionId}).first?.text
                } else if let dateVal = response.dateValue, value == nil {
                    value = dateVal
                }
                if value != nil {
                    self.arrBotResponse.append((type: BotOptionType.rightTextView, message: nil, option: [], setting: nil, time: Date().toString(format: "h:mm a"), value: value, stepResponseMessage: nil))
                    self.reloadAndScrollToBottom()
                }
            }
            if let objStepResponse = self.chatBotViewModel.currentStep?.stepResponse {
                if let arrStepMessage = objStepResponse.stepResponseMessages {
                    for object in arrStepMessage {
                        self.arrBotResponse.append((type: BotOptionType.textView, message: nil, option: [], setting: nil, time: Date().toString(format: "h:mm a"), value: nil, stepResponseMessage: object))
                    }
                    self.reloadAndScrollToBottom()
                    
                }
            }
        }
        guard let currentStep = self.chatBotViewModel.currentStep else {
            return
        }
        let type = BotOptionType(rawValue: currentStep.type ?? "") ?? .shortText
        let arrMessages = self.chatBotViewModel.currentStep?.stepMessages ?? []
        
        if arrMessages.count <= self.messageIndex {
         
            self.arrBotResponse.append((type: type, message: nil, option: currentStep.stepOptions, setting: nil, time: Date().toString(format: "h:mm a"), value: nil, stepResponseMessage: nil))
            self.reloadAndScrollToBottom()
            self.optionStartTime = Date()
            return
        } else {
            let arrMessages = (currentStep.stepMessages ?? []).sorted(by: {$0.position ?? 0 < $1.position ?? 0})
            let delay = arrMessages[self.messageIndex].delay ?? 2000
            self.showTypingFor(delay) {
                self.arrBotResponse.append((type: type, message: arrMessages[self.messageIndex], option: nil, setting: nil, time: Date().toString(format: "h:mm a"), value: nil, stepResponseMessage: nil))
                self.reloadAndScrollToBottom()
                self.messageIndex += 1
               self.loadCurrentChatbotStep(isRepeat: true)
               // self.postCurrentStepData()
            }
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
                        self.faqTableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .none, animated: true)
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
                self.faqTableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .none, animated: true)
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
                self.faqTableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .none, animated: true)
            }
        }
    }
    
    // MARK: - API Calls
    private func getallFAQSteps() {
        ProgressHUD.show()
       // chatbotViewModel.chatbotId = self.botId
        chatBotViewModel.getFAQAllSteps { isSuccess, error, faqModel in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                   // self.loadPreviousChatbotStep(objPreviousSteps: objPreviousRes)
                   // self.getPreviousSteps()
                    self.getstepById()
                }
                else {
                    self.showErrorToast(error)
                   // self.alertMessage(title: errMessage ?? "Oops!Something went wrong")
                }
            }
        }
       
    }
  
    private func getPreviousSteps() {
        ProgressHUD.show()
      //  chatbotViewModel.chatbotId = self.botId
       // chatbotViewModel.getPreviousStep(completion: <#T##(Bool, String?, PreviousStepResponse?) -> ()#>)
        chatBotViewModel.getPreviousStep { isSuccess, error, previousSteps in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                  //  self.loadPreviousChatbotStep(objPreviousSteps: previousSteps)
                } else {
//                    self.showErrorToast(errMessage)
                    self.alertMessage(title: error ?? "Oops!Something went wrong")
                }
            }
        }
       
    }
    
    private func getCurrentStep(botstepId:String, isRepeat: Bool, isShowLoader: Bool = true) {
        if isShowLoader {
            ProgressHUD.show()
        }
        chatBotViewModel.chatbotId = self.botStepId
        chatBotViewModel.getCurrentStepFAQ { isSuccess, errMessage, faqResponse in
            if isShowLoader {
                ProgressHUD.dismiss()
            }
            DispatchQueue.main.async {
                if isSuccess {
                     self.messageIndex = 0
                     self.loadCurrentChatbotStep(isRepeat: isRepeat)
                    // self.loadPreviousChatbotStep(objPreviousSteps: faqResponse)
                }
            }
        }
          }
      

    private func postCurrentStepData(value: String) {
//        ProgressHUD.show()
        //chatBotViewModel.timeTaken = Int(timeTaken)
        chatBotViewModel.value = value
        chatBotViewModel.previewNextStep {  isSuccess, error, previewData in
            ProgressHUD.dismiss()
                      DispatchQueue.main.async {
                          if isSuccess {
                              self.removeLastStepOption()
                              if let prevStep = previewData?.prevStep, prevStep != nil {
                                      for response in prevStep.stepResponseMessages ?? [] {
                                          self.botStepId = response.botStepId
                                          self.chatBotViewModel.stepId = self.botStepId
                                        //  self.loadPreviousChatbotStep(objPreviousSteps: chatbotsteps)
                                          self.loadCurrentChatbotStep(isRepeat: false )
                                         // self.getCurrentStep(botstepId: self.botStepId ?? "", isRepeat: false, isShowLoader: false)
                                         self.getstepById()
                                      
                                  }
                              }
                              if let currentSteps = previewData?.currentStep, currentSteps != nil {
                                  self.loadCurrentChatbotStep(isRepeat: true )
//                                  self.loadPreviousChatbotStep(objPreviousSteps: chatbotsteps)
                                 // self.getstepById()
                              }
                          
                              
                          } else {
                             // self.showErrorToast(error)
                              self.alertMessage(title: error ?? "Oops!Something went wrong")
                          }
                      }
        }
       
    }

    
    private func getstepById() {
        ProgressHUD.show()
      //  chatbotViewModel.chatbotId = self.botId
       // chatbotViewModel.getPreviousStep(completion: <#T##(Bool, String?, PreviousStepResponse?) -> ()#>)
        chatBotViewModel.getStepData { isSuccess, errMessage, chatbotsteps  in
            
                ProgressHUD.dismiss()
                DispatchQueue.main.async {
                    if isSuccess {
                       
                        self.loadPreviousChatbotStep(objPreviousSteps: chatbotsteps)
                       // self.loadCurrentChatbotStep(isRepeat: true)
                        
                    } else {
                       self.showErrorToast(errMessage)
                      //  self.alertMessage(title: error ?? "Oops!Something went wrong")
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
extension FAQChatBotViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrBotResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = self.arrBotResponse[indexPath.row]
        print(self.arrBotResponse)
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
                    let cell = tableView.dequeueReusableCell(withClass: LinkToWebCell.self)

                    cell.lblText.text = message.attachmentUrl
                    cell.lblTime.text = object.time
                    return cell
                case .educationLesson :
                    let cell = tableView.dequeueReusableCell(withClass: LeftTextViewCell.self)
                    cell.lblText.text = message.text
                    cell.lblTime.text = object.time
                    return cell
                case .Bot :
                    break;
                }
            } else {
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
                    cell.arrOptions = object.option as! [StepOption]
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
                   // cell.delegate = self
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
        return UITableViewCell()
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
//                if indexPath == lastVisibleIndexPath {
//                    // do here...
//                    self.showSuccessToast("This Conversation ended")
//                   // self.showErrorToast("Bots Completed")
//                }
//            }
//
//    }
    
    @IBAction func onBtnSubmit(sender: UIButton) {
        if let cell = self.faqTableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? TextNumberInputCell, let value = cell.txtInput.text {
            self.optionEndTime = Date()
            if let startTime = self.optionStartTime, let endTime = self.optionEndTime {
                let timeTaken = Int(endTime.timeIntervalSince(startTime) * 1000)
               // self.postCurrentStepData(value: value, timeTaken: timeTaken)
                self.postCurrentStepData(value: value)
            }
        }
    }
    
    @IBAction func onBtnYesNoTap(sender: UIButton) {
        if let cell = self.faqTableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? YesNoCell,
            let options = cell.arrOptions {
            self.optionEndTime = Date()
            if let startTime = self.optionStartTime, let endTime = self.optionEndTime {
                let timeTaken = Int(endTime.timeIntervalSince(startTime) * 1000)
                let yesNo = sender.titleLabel?.text == "yes" ? "yes" : "no"
                let value = options.filter({$0.text == yesNo}).first?.id ?? ""
                //self.postCurrentStepData(value: value, timeTaken: timeTaken)
                self.postCurrentStepData(value: value)
            }
        }
    }
    
    @IBAction func onCalendarSubmit(sender: UIButton) {
        if let cell = self.faqTableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? DatePickerCell {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let selectedDate = dateFormatter.string(from: cell.datePicker.date)
            
            self.optionEndTime = Date()
            if let startTime = self.optionStartTime, let endTime = self.optionEndTime {
                let timeTaken = Int(endTime.timeIntervalSince(startTime) * 1000)
                //self.postCurrentStepData(value: selectedDate, timeTaken: timeTaken)
                self.postCurrentStepData(value: selectedDate)
            }
        }
    }
    
    @IBAction func onSliderValueChange(sender: UISlider) {
        if let cell = self.faqTableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? SliderCell {
            let value = "\(Int(cell.slider.value))"
            
            self.optionEndTime = Date()
            if let startTime = self.optionStartTime, let endTime = self.optionEndTime {
                let timeTaken = Int(endTime.timeIntervalSince(startTime) * 1000)
                //self.postCurrentStepData(value: value, timeTaken: timeTaken)
                self.postCurrentStepData(value: value)
            }
        }
    }
    
    
}

// MARK: - MCQDelegate
extension FAQChatBotViewController: MCQDelegate {
   
    
    func onFAQObjSelect(object: Options?) {
                     
        self.optionEndTime = Date()
        if let startTime = self.optionStartTime, let endTime = self.optionEndTime {
            let timeTaken = Int(endTime.timeIntervalSince(startTime) * 1000)
            if let value = object?.id {
                //self.postCurrentStepData(value: value, timeTaken: timeTaken)
                self.postCurrentStepData(value: value)
           // }
        }
    }
    }
    
    
    func onObjectSelection(object: StepOption?) {
     
        self.optionEndTime = Date()
//        if let startTime = self.optionStartTime, let endTime = self.optionEndTime {
//            let timeTaken = Int(endTime.timeIntervalSince(startTime) * 1000)
            if let value = object?.id {
              
               // self.postCurrentStepData(value: value, timeTaken: timeTaken)
                self.postCurrentStepData(value: value)
            //}
        }
    }
}

// MARK: - TextViewDelegate
extension FAQChatBotViewController: TextViewDelegate {
    func moveToWebPage(link: String) {
        let topicSB = UIStoryboard(name: "Topics", bundle: nil)
        if let webVC = topicSB.instantiateViewController(withIdentifier: WebViewController.identifier) as? WebViewController {
            webVC.pageId = link
            self.navigationController?.pushViewController(webVC, animated: true)
        }
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
   
}

