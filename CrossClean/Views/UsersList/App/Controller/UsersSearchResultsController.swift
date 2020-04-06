//
//  UsersSearchResultsController.swift
//  SimplefiedCleanApp
//
//  Created by Marcelo Sarquis on 01.04.20.
//  Copyright © 2020 10s. All rights reserved.
//

import UIKit

class UsersSearchResultsController: UITableViewController {

    private var users = [User]()
    
    private let dataSource: UsersListViewControllerDataSource
    init() {
        dataSource = UsersListViewControllerDataSource()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.register(UsersListTableViewCell.nib, forCellReuseIdentifier: UsersListTableViewCell.identifier)
        tableView.tableFooterView = UIView()
    }
    
    func setupDataSource(with languages: [User]) {
        dataSource.setup(with: languages)
        tableView.reloadData()
    }
}
