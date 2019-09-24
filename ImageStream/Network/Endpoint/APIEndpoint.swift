//
//  APIURLBuilder.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/21/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

/// Creates a URL for an API request.
class APIEndpoint: Endpoint {
    let path: String
    let queryItems: [String: String]

    init(
        path: String,
        queryItems: [String: String]
    ) {
        self.path = path
        self.queryItems = queryItems
    }
}

extension Endpoint where Self: APIEndpoint {
    /// Constructs the URL using the baseURL and queryArguments.
    var url: String {
        var url = path + "?"
        queryItems.forEach { (key, value) in
            url += "&" + key + "=" + value
        }
        return url
    }
}
