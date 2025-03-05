//
//  NewsDetailView.swift
//  News-Concurrency
//
//  Created by Rodrigo on 05/03/2025.
//

import SwiftUI

struct NewsDetailView: View {
    let newsItem: NewsItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(newsItem.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(newsItem.publishedAt)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                //Cargar la imagen de forma asincronica
                if let imageUrl = newsItem.image, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity, minHeight: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(8)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, minHeight: 200)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, minHeight: 200)
                        .foregroundColor(.gray)
                }
                
                if let description = newsItem.description {
                    Text(description)
                        .font(.body)
                }
                
                Link("Read full article", destination: URL(string: newsItem.url)!)
                    .font(.callout)
                    .foregroundColor(.blue)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("News Detail")
    }
}
