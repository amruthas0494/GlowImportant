//
//  BookmarkViewModel.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 15/04/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class BookmarkViewModel: NSObject {
    var bookmarkPages = [Bookmark]()

    func getBookmarkList(complition: @escaping (Bool, String?, [Bookmark]?) -> ()) {
        
        SessionManager.default.requestModel(request: Router.bookmarksList.urlRequest()) { (response: [Bookmark]?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err, nil)
                case .none:
                    complition(false, DEFAULT_API_ERROR(), nil)
                }
            } else {
                self.bookmarkPages.removeAll()
                self.bookmarkPages = response ?? []
                complition(true, nil, response)
            }
        }
    }
}
