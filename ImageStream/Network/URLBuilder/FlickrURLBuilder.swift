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
class FlickrURLBuilder: APIURLBuiler {
    private var apiKey: String
    private var method: Method
    
    init(baseURL: String = "https://www.flickr.com/services/rest/",
         apiKey: String = flickrAPIKey,
         method: Method,
         queryArguments: [String: String]) {
        
        self.apiKey = apiKey
        self.method = method
        
        super.init(baseURL: baseURL, queryArguments: queryArguments)
        
        self.queryArguments["api_key"] = apiKey
        self.queryArguments["method"] = method.rawValue
    }
}

extension FlickrURLBuilder {
    //TODO: Add more methods
    /// Method names for Flickr API Requests.
    enum Method: String {
        case photosSearch = "flickr.photos.search"
        case getInfo = "flickr.photos.getInfo"
    }
}
