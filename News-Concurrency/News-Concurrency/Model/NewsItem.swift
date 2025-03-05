//
//  NewsItem.swift
//  News-Concurrency
//
//  Created by Rodrigo on 05/03/2025.
//

import Foundation

struct NewsItem: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String?
    let url: String
    let publishedAt: String
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case url
        case publishedAt
        case image
    }
}
