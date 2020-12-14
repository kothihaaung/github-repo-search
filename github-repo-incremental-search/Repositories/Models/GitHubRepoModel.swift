//
//  GitHubRepoModel.swift
//  github-repo-incremental-search
//
//  Created by Thiha Aung on 2020/12/14.
//

struct SearchResult: Codable {
    var totalCount: Int
    var items: [Item]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count", items
    }

    struct Item: Codable {
        var id: Int
        var name: String
        var fullName: String
        
        private enum CodingKeys: String, CodingKey {
            case id, name, fullName = "full_name"
        }
    }
}
