//
//  NewsRowView.swift
//  News-Concurrency
//
//  Created by Rodrigo on 05/03/2025.
//
import SwiftUI

struct NewsRowView: View {
    let newsItem: NewsItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(newsItem.title)
                .font(.headline)
            if let description = newsItem.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Text(newsItem.publishedAt)
                .font(.caption)
        }
        .padding(.vertical, 4)
    }
}
