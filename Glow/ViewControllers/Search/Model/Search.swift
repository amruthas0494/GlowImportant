//
//  Search.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 28/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation

struct SearchData: Codable {
    
    var hits: Int?
    var results: [SearchResult]?
}

struct SearchResult: Codable {
    
    var id: String?
    var name: String?
    var description: String?
    var imageUrl: String?
}

struct Search: Codable {
    
    var id: String?
    var keyword: String?
    var hits: String?
    var userId: String?
}
