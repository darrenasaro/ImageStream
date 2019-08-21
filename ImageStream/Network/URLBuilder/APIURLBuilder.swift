//
//  APIURLBuilder.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/21/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

/// Creates a URL for an API request.
class APIURLBuiler {
    let baseURL: String
    var queryArguments: [String: String]
    
    init(baseURL: String, queryArguments: [String: String]) {
        self.baseURL = baseURL
        self.queryArguments = queryArguments
    }
}

extension APIURLBuiler: URLBuilder {
    /// Constructs the URL using the baseURL and queryArguments.
    @objc var url: String {
        var url = baseURL + "?"
        queryArguments.forEach { (key, value) in
            url += "&" + key + "=" + value
        }
        return url
    }
}
