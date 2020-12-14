//
//  ViewController.swift
//  github-repo-incremental-search
//
//  Created by Thiha Aung on 2020/12/14.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.tableView.dataSource = self
        self.viewModel.delegate = self
    }
}

/// When search bar text changed, throttle for 5 seconds and search.
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.search(searchText)
    }
}

/// Table view data source.
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "repo-cell") else {
            return UITableViewCell()
        }
        
        let item = self.viewModel.items[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.fullName
        
        return cell
    }
}

/// Reload the table view for updated search results.
extension MainViewController: MainViewModelDelegate {
    func mainViewModelDidRefresh(_ viewModel: MainViewModel) {
        self.tableView.reloadData()
    }
}

