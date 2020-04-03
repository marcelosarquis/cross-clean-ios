//
//  UserDetailViewController.swift
//  CrossClean
//
//  Created by Marcelo Sarquis on 02.04.20.
//  Copyright © 2020 10s. All rights reserved.
//

import UIKit

protocol UserDetailViewControllerDelegate: AnyObject {
    func detailsViewControlleDidFinish(with error: Error)
}

protocol UserDetailViewControllerDependencies {
    var userDetailUseCase: UserDetailUseCase { get }
}

class UserDetailViewController: UITableViewController {
    
    weak var delegate: UserDetailViewControllerDelegate?
    
    private lazy var dataSource: UserDetailViewControllerDataSource = {
        let dataSource = UserDetailViewControllerDataSource()
        return dataSource
    }()
    
    private let dependencies: UserDetailViewControllerDependencies
    private let user: User
    init(
        dependencies: UserDetailViewControllerDependencies,
        user: User
    ) {
        self.dependencies = dependencies
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = user.name
        tableView.dataSource = dataSource
        tableView.register(PostTableViewCell.nib, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        
        dependencies.userDetailUseCase.fetchPost(from: user.id.description) { [weak self] result in
            switch result {
            case let .success(posts):
                self?.dataSource.setup(with: posts)
                self?.tableView.reloadData()
            case let .failure(error):
                self?.delegate?.detailsViewControlleDidFinish(with: error)
            }
        }
    }
}
