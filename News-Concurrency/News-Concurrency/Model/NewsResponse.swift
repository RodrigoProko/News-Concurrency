//
//  NewsResponse.swift
//  News-Concurrency
//
//  Created by Rodrigo on 05/03/2025.
//

import Foundation

struct NewsResponse: Codable {
    let totalArticles: Int
    let articles: [NewsItem]
    
    enum CodingKeys: String, CodingKey {
        case totalArticles
        case articles
    }
}
