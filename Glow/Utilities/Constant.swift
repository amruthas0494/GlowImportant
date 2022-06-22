//
//  Constant.swift
//  Glow
//
//  Created by Pushpa Yadav on 27/10/21.
//  Copyright © 2021 CC. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    
    struct HttpMethod {
        static let get = "GET"
        static let put = "PUT"
        static let post = "POST"
        static let patch = "PATCH"
        static let delete = "DELETE"
    }
    
    struct NetworkConstants {
        static var requestTimeout: TimeInterval = 60.0
        static var resourseTimeout: TimeInterval = 60.0
        static let keyPath = "data"
        static let backgroundTask = "backgroundTaskId"
    }
    
    //    struct Font_Poppins {
    //        static let extraBold = "Poppins-ExtraBold"
    //        static let extraLight = "Poppins-ExtraLight"
    //        static let black = "Poppins-Black"
    //        static let bold = "Poppins-Bold"
    //        static let light = "Poppins-Light"
    //        static let medium = "Poppins-Medium"
    //        static let regular = "Poppins-Regular"
    //        static let semiBold = "Poppins-SemiBold"
    //        static let thin = "Poppins-Thin"
    //    }
    
    struct loginConstants {
        static let login = "isLoggedIn"
        static let authToken = "authToken"
        static let fcmToken = "fcmToken"
        static let userId = "userId"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let imageProfile = "imageProfile"
    }
    struct Title {
        static let kStepOne = "Step One"
        static let kStepTwo = "Step Two"
        static let kStepThree = "Step Three"
        static let kStepFour = "Step Four"
        static let kStepFive = "Step Five"
        static let kCreateYourAccount = "Create your account!"
        static let kTellMeMore = "Tell me more about yourself"
        static let kCorrectInformation = "Please, choose the correct information regarding your diabetes status"
        static let kBackgroundQuiz = "Background Quiz"
        static let kPersonaliseAppearance = "Personalise the appearance!"
    }
}
// MARK: - Radius & Border

extension Constant {
    static let viewRadius4: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 4 : 8
    static let viewRadius8: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 8 : 16
    static let viewRadius12: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 12 : 24
    static let viewRadius16: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 16 : 32
    static let viewRadius23: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 23 : 46
    static let buttonRadius: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 8 : 16
    static let viewBorder: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 2 : 4
    static let viewBorder3: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 3 : 6
    static let viewBorder5: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 5 : 10
    static let viewBorder1: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 1 : 2
    static let educationCollectionCellLineSpacing: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 20 : 40
    static let educationCollectionCellHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 211 : 422
    static let educationTableCellHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 326 : 652
    static let starSize: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 20 : 40
    static let starMargin: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 14 : 28
}

// MARK: - Button and DatePicker

extension Constant {
    static let buttonImageHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 49 : 98
    static let buttonImageWidth: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 49 : 98
    static let buttonxAxis: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 295 : 590
    static let buttonyAxis: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 10 : 20
    static let datePickerHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 216 : 432
    static let dropDownHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 49 : 98
}


// MARK: - EdgeInset of textview

extension Constant {
    static let txtVwEdge: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 12 : 24
    static let topEdge: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 16 : 32
    static let leftEdge: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 16 : 32
    static let BottomEdge: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 16 : 32
    static let RightEdge: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 12 : 24
    static let titleleftEdge: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 10 : 20
    static let ImageleftEdge: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? -10 : -20
    static let btnImgInsetLeft: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 320 : 640
    
}

extension Constant {
    static let tableViewcellHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 130 : 260
    static let tableSectionHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 81 : 162
}

// MARK: - constraints of UIView elements

extension Constant {
    static let TlabelTop: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 24 : 48
    static let Tlabelleading: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 163 : 326
    static let Tlabeltrailing: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 163 : 326
    static let TLabelBottom: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 240 : 480
    static let Tlabelverticalspacing: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 16 : 32
    static let UlabelTop: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 60 : 120
     static let Ulabelleading: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 51 : 105
     static let Ulabeltrailing: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 51 : 105
     static let ULabelBottom: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 172 : 344
    static let nextButtontop: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 136 : 272
     static let nextButtonleading: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 16 : 32
     static let nextButtontrailing: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 16 : 32
     static let nextButtonBottom: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 104 : 210
    static let  dashButtontop: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 207 : 414
     static let dashButtonleading: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 16 : 32
     static let dashButtontrailing: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 16 : 32
    static let dashButtonbottom: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 44 : 88
     static let buttonHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 40 : 80
    
    static let  containerstackTop: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 24 : 48
       static let containerstackbottom: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? -24 : -48
       static let containerstackleading: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 24 : 48
      static let containerstacktrailing: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? -24 : -48
     static let containerstackSpace: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 16 : 32
    
    
}

enum AppConstant: String {
    case token = "Token"
    case user = "User"
    case authVerificationID = "AuthVerificationID"
    case isLogin = "isLogin"
    case fcmToken = "FcmToken"
    case voipToken = "voipToken"
    case fingerAuth = "fingerAuth"
    case deletedTipId = "deletedTipId"
    case loggedUserId = "loggedUserId"
}
