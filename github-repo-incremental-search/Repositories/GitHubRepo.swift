//
//  GithubRepo.swift
//  github-repo-incremental-search
//
//  Created by Thiha Aung on 2020/12/14.
//

import Foundation

class GitHubRepo {
    func search(_ searchText: String, completion: @escaping ((SearchResult) -> Void)) {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(searchText)&sort=stars&order=desc") else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            if let searchResult = try? JSONDecoder().decode(SearchResult.self, from: data) {
                DispatchQueue.main.async {
                    completion(searchResult)
                }
            }
        }

        task.resume()
    }
}


