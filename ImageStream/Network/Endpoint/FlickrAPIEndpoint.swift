//
//  FlickrURLBuilder.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/21/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

fileprivate let flickrAPIKey = "8fc4e611f9c6ebc9d1f8c48ff92ece14"

/// Creates a URL specific to the Flickr API.
class FlickrAPIEndpoint: APIEndpoint {
    init(
        apiKey: String = flickrAPIKey,
        method: Method,
        queryItems: [String: String]
    ) {
        var inputQueryItems = queryItems
        inputQueryItems["api_key"] = apiKey
        inputQueryItems["method"] = method.rawValue
        super.init(
            path: "https://www.flickr.com/services/rest/",
            queryItems: inputQueryItems
        )
    }
}

extension FlickrAPIEndpoint {
    /// Method names for Flickr API Requests.
    enum Method: String {
        case photosSearch = "flickr.photos.search"
        case getInfo = "flickr.photos.getInfo"
    }
}
