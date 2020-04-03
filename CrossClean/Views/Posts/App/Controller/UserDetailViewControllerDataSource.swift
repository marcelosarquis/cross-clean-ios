//
//  UserDetailViewControllerDataSource.swift
//  CrossClean
//
//  Created by Marcelo Sarquis on 02.04.20.
//  Copyright © 2020 10s. All rights reserved.
//

import UIKit

class UserDetailViewControllerDataSource: NSObject {
    
    private var posts = [Post]()
    func setup(with posts: [Post]) {
        self.posts = posts.sorted { $0.id < $1.id }
    }
}

extension UserDetailViewControllerDataSource: UITableViewDataSource {
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = post.titleDescription
        cell.bodyTextView.text = post.body
        return cell
    }
}
