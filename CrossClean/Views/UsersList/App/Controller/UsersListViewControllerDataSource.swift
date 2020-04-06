//
//  UsersListViewControllerDataSource.swift
//  SimplefiedCleanApp
//
//  Created by Marcelo Sarquis on 01.04.20.
//  Copyright © 2020 10s. All rights reserved.
//

import UIKit

class UsersListViewControllerDataSource: NSObject {
    
    private var users = [User]()
    private var filteredUsers = [String: [User]]()
    private var indexTitles = [String]()
    func setup(with users: [User]) {
        self.users = users
        update(with: self.users)
    }

    func update(with usersList: [User]) {
        let sortedInsurances = usersList
            .sorted { $0.name < $1.name }
        let indexTitleUsersMap = sortedInsurances.reduce([String: [User]]()) {
            guard let char: Character = $1.name.first else { return $0 }
            let key = String(char)
            var collection = $0
            var array = collection[key] ?? [User]()
            array.append($1)
            collection[key] = array
            return collection
        }
        indexTitles = Array(indexTitleUsersMap.keys).sorted { $0 < $1 }
        filteredUsers = indexTitleUsersMap
    }

    func users(for section: Int) -> [User]? {
        let key = indexTitles[section]
        return filteredUsers[key]
    }

    func getUser(for indexPath: IndexPath) -> User? {
        guard let array = users(for: indexPath.section) else { return nil }
        let user = array[indexPath.row]
        return user
    }
    
    func getIndexPath(for user: User) -> IndexPath? {
        guard let char: Character = user.name.first,
            let section = indexTitles.firstIndex(of: String(char)),
            let array = users(for: section),
            let row = array.firstIndex(where: { $0.name == user.name }) else { return nil }
        return IndexPath(row: row, section: section)
    }

    func search(_ query: String) {
        guard !query.isEmpty else {
            update(with: users)
            return
        }
        update(with: filteredUsers(query))
    }
    
    func filteredUsers(_ query: String) -> [User] {
        return self.users.filter { $0.name.lowercased().contains(query.lowercased()) }
    }
}

extension UsersListViewControllerDataSource: UITableViewDataSource {
    
    func numberOfSections(in _: UITableView) -> Int {
        return indexTitles.count
    }

    func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard indexTitles.count > 0 else { return nil }
        return indexTitles[section]
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let array = users(for: section) else { return 0 }
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let array = users(for: indexPath.section) else { preconditionFailure() }
        let user = array[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersListTableViewCell.identifier, for: indexPath) as? UsersListTableViewCell else { return UITableViewCell() }
        cell.nameLabel.text = user.fullName
        cell.addressLabel.text = user.address.fullAddress
        cell.phoneLabel.text = user.phone.numeric
        return cell
    }
}
