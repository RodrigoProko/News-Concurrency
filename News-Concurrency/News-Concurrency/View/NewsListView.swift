//
//  NewsListView.swift
//  News-Concurrency
//
//  Created by Rodrigo on 05/03/2025.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.newsItems) { item in
                    NavigationLink(destination: NewsDetailView(newsItem: item)) {
                        NewsRowView(newsItem: item)
                    }
                    .task {
                        if item.id == viewModel.newsItems.last?.id {
                            viewModel.loadMoreNews()
                        }
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Tech News")
            .task {
                await viewModel.loadInitialNews()
            }
            .refreshable {
                await viewModel.loadInitialNews()
            }
            .alert(isPresented: Binding(
                get: { viewModel.error != nil },
                set: { _ in viewModel.clearError() }
            )) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.error?.localizedDescription ?? "Unknown error"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}


#Preview {
    NewsListView()
}
