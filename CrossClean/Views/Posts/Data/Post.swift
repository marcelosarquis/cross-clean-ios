//
//  Post.swift
//  CrossClean
//
//  Created by Marcelo Sarquis on 02.04.20.
//  Copyright © 2020 10s. All rights reserved.
//

import Autobahn
import Foundation
import UIKit

struct Post: Decodable {
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    var titleDescription: String {
        return "\(id.description). \(title)"
    }
}

struct PostRequest: RequestProtocol {
    typealias Response = [Post]
    
    let method: HTTP.Method = .get
    let endpoint: EndpointProtocol
    init(userId: String) {
        endpoint = PostEndpoint.getUserPosts(userId: userId)
    }
}

enum PostEndpoint: EndpointProtocol {
    case getUserPosts(userId: String)
    
    var base: String { "https://jsonplaceholder.typicode.com" }
    var path: String { "posts" }
    var queryParameters: [String: String] {
        switch self {
        case let .getUserPosts(userId: userId):
            return ["userId": userId]
        }
    }
}

