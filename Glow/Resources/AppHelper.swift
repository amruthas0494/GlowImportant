//
//  AppHelper.swift
//  Glow
//
//  Created by Cognitiveclouds on 21/03/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class AppHelper: NSObject {

        static func getLocalizeString(str:String) -> String {
            let string = Bundle.main.path(forResource: UserDefaults.standard.string(forKey: "Language"), ofType: "lproj")
            let myBundle = Bundle(path: string!)
            return (myBundle?.localizedString(forKey: str, value: "", table: nil))!
        }
    

}
