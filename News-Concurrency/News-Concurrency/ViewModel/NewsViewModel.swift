//
//  NewsViewModel.swift
//  News-Concurrency
//
//  Created by Rodrigo on 05/03/2025.
//

import Foundation

@MainActor
class NewsViewModel: ObservableObject {
    @Published private(set) var newsItems: [NewsItem] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    private let service = NewsService()
    private var currentPage = 1
    private let pageSize = 20
    private var totalArticles = 0
    private var loadingTask: Task<Void, Never>?
    
    func loadInitialNews() async {
        guard !isLoading else { return }
        isLoading = true
        error = nil
        
        do {
            let response = try await service.fetchNews(page: 1, pageSize: pageSize)
            newsItems = response.articles
            totalArticles = response.totalArticles
            currentPage = 1
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func loadMoreNews() {
        guard !isLoading && (newsItems.count < totalArticles) else { return }
        
        loadingTask?.cancel()
        loadingTask = Task { @MainActor in
            isLoading = true
            error = nil
            currentPage += 1
            
            do {
                let response = try await service.fetchNews(page: currentPage, pageSize: pageSize)
                newsItems.append(contentsOf: response.articles)
                totalArticles = response.totalArticles
            } catch {
                self.error = error
                currentPage -= 1
            }
            
            isLoading = false
        }
    }
    
    func cancelLoading() {
        loadingTask?.cancel()
    }
    
    func clearError() {
        error = nil
    }
}
