//
//  UsersListViewController.swift
//  SimplefiedCleanApp
//
//  Created by Marcelo Sarquis on 01.04.20.
//  Copyright © 2020 10s. All rights reserved.
//

import UIKit

protocol UsersListViewControllerDelegate: AnyObject {
    func usersViewControlleDidFinish(with error: Error)
    func usersViewControlleDidSelect(_ user: User)
}

protocol UsersListViewControllerDependencies {
    var userListUseCase: UserListUseCase { get }
}

class UsersListViewController: UITableViewController {

    weak var delegate: UsersListViewControllerDelegate?
    
    lazy var searchController: UISearchController = {
        let usersSearchResultsController = UsersSearchResultsController()
        usersSearchResultsController.tableView.delegate = self
        let searchController = UISearchController(searchResultsController: usersSearchResultsController)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.searchBarStyle = .minimal
        return searchController
    }()
    
    private lazy var dataSource: UsersListViewControllerDataSource = {
        let dataSource = UsersListViewControllerDataSource()
        return dataSource
    }()
    
    private let dependencies: UsersListViewControllerDependencies
    init(dependencies: UsersListViewControllerDependencies) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Users"
        tableView.dataSource = dataSource
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        tableView.tableFooterView = UIView()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        dependencies.userListUseCase.fetch { [weak self] result in
            switch result {
            case let .success(users):
                self?.dataSource.setup(with: users)
                self?.tableView.reloadData()
            case let .failure(error):
                self?.delegate?.usersViewControlleDidFinish(with: error)
            }
        }
    }
}

extension UsersListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = dataSource.getUser(for: indexPath) else { return }
        delegate?.usersViewControlleDidSelect(user)
    }
}

extension UsersListViewController: UISearchBarDelegate {
    
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        dataSource.search(searchText)
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_: UISearchBar) {
        dataSource.search("")
        tableView.reloadData()
    }
}

extension UsersListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, let usersSearchResultsController = searchController.searchResultsController as? UsersSearchResultsController else { return }
        let searchResults = dataSource.filter(searchText)
        usersSearchResultsController.setupDataSource(with: searchResults)
    }
}
