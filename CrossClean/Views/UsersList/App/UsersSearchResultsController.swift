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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
    func setupDataSource(with languages: [User]) {
        dataSource.setup(with: languages)
        tableView.reloadData()
    }

}
