//
//  User.swift
//  SimplefiedCleanApp
//
//  Created by Marcelo Sarquis on 01.04.20.
//  Copyright © 2020 10s. All rights reserved.
//

import Foundation
import Autobahn

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company

    struct Address: Decodable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: Geo

        struct Geo: Decodable {
            let lat: String
            let lng: String
        }
    }

    struct Company: Decodable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}

struct UserRequest: RequestProtocol {
    typealias Response = [User]
    let endpoint: EndpointProtocol = UserEndpoint()
    let method: HTTP.Method = .get
}

struct UserEndpoint: EndpointProtocol {
    let base: String = "https://jsonplaceholder.typicode.com"
    let path: String = "users"
}
