//
//  FavouriteModuleViewModel.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 25/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation

class FavouriteModuleViewModel: NSObject {
    
    var arrFavouriteLessons = [FavouriteModule]()
    
    func getFavouriteLessons(complition: @escaping (Bool, String?) -> ()) {
        guard let userId = Glow.sharedInstance.userId else {
            return
        }
        SessionManager.default.requestModel(request: Router.favourites(userId: userId).urlRequest()) { (response: [FavouriteModule]?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err)
                case .none:
                    complition(false, DEFAULT_API_ERROR())
                }
            } else {
                self.arrFavouriteLessons.removeAll()
                self.arrFavouriteLessons = response ?? []
                print("fav modules are:L",self.arrFavouriteLessons)
            }
            complition(true, nil)
        }
    }
}
