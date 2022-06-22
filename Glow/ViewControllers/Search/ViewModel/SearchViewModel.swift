//
//  SearchViewModel.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 28/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation

class SearchViewModel: NSObject {
    
    var searchId: String?
    var keyword: String?
    var arrSearchResult = [SearchResult]()
    var arrRecentSearch = [Search]()
    
    func getRecentSearches(complition: @escaping (Bool, String?) -> ()) {
        SessionManager.default.requestModel(request: Router.getRecentSearches.urlRequest()) { (response: [Search]?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err)
                case .none:
                    complition(false, DEFAULT_API_ERROR())
                }
            } else {
                self.arrRecentSearch.removeAll()
                self.arrRecentSearch = response ?? []
            }
            complition(true, nil)
        }
    }
    
    func createRecentSearch() {
        guard let keyword = keyword else {
            return
        }
        SessionManager.default.requestModel(request: Router.createRecentSearch(keyword: keyword).urlRequest()) { (response: String?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    print(err)
                case .none:
                    print(DEFAULT_API_ERROR())
                }
            }
            print("Success")
        }
    }
    
    func deleteRecentSearch(complition: @escaping (Bool, String?) -> ()) {
        guard let searchId = searchId else {
            return
        }
        SessionManager.default.requestModel(request: Router.deleteRecentSearch(searchId: searchId).urlRequest()) { (response: String?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err)
                case .none:
                    complition(false, DEFAULT_API_ERROR())
                }
            }
            complition(true, nil)
        }
    }
    
    func getSearchResult(complition: @escaping (Bool, String?) -> ()) {
        guard let keyword = keyword else {
            complition(false, nil)
            return
        }
        SessionManager.default.requestModel(request: Router.search(keyword: keyword).urlRequest()) { (response: SearchData?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err)
                case .none:
                    complition(false, DEFAULT_API_ERROR())
                }
            } else {
                self.arrSearchResult.removeAll()
                self.arrSearchResult = response?.results ?? []
            }
            complition(true, nil)
        }
    }
    
    func cancelAllSearch() {
        if let keyword = keyword, let path = Router.search(keyword: keyword).urlRequest().url?.path {
            SessionManager.default.cancelAllRequest(for: path)
        }
    }
}
