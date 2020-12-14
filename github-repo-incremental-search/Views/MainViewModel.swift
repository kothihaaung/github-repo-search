//
//  MainViewModel.swift
//  github-repo-incremental-search
//
//  Created by Thiha Aung on 2020/12/14.
//

import Foundation

protocol MainViewModelDelegate: class {
    func mainViewModelDidRefresh(_ viewModel: MainViewModel)
}

class MainViewModel {
    private let repo = GitHubRepo()
    private let throttler = Throttler(minimumDelay: 0.5)
    
    private var searchResult: SearchResult? {
        didSet {
            if let _ = self.searchResult, let delegate = self.delegate {
                delegate.mainViewModelDidRefresh(self)
            }
        }
    }
    
    weak var delegate: MainViewModelDelegate?
    
    var items: [SearchResult.Item] {
        guard let searchResult = self.searchResult else {
            return []
        }
        
        return searchResult.items
    }
    
    func search(_ searchText: String) {
        self.throttler.throttle {
            self.repo.search(searchText) { searchResult in
                self.searchResult = searchResult
            }
        }
    }
}
