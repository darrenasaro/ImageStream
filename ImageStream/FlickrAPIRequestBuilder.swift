//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

//TODO: Add more methods
enum FlickrAPIMethod: String {
    case photosSearch = "flickr.photos.search"
}

class FlickrAPIRequestBuilder {
    private let baseUrl = "https://www.flickr.com/services/rest/"
    
    private var apiKey: String
    private var method: FlickrAPIMethod
    private var queryArguments: [String : String]
    
    var url: String {
        var url = baseUrl + "?method=" + method.rawValue + "&api_key=" + apiKey
        queryArguments.forEach { (key, value) in
            url += "&" + key + "=" + value
        }
        return url
    }
    
    init(apiKey: String, method: FlickrAPIMethod, queryArguments: [String : String]) {
        self.apiKey = apiKey
        self.method = method
        self.queryArguments = queryArguments
    }
}

class SearchPhotosRequestBuilder: FlickrAPIRequestBuilder {
    init(searchString: String) {
        
        let apiKey = "8fc4e611f9c6ebc9d1f8c48ff92ece14"
        let postSearchMethod = FlickrAPIMethod.photosSearch
        let postSearchQueryArgs = ["text" : searchString,
                                   "sort" : "relevance",
                                   "format" : "json",
                                   "nojsoncallback" : "1"]
        
        super.init(apiKey: apiKey,
                   method: postSearchMethod,
                   queryArguments: postSearchQueryArgs)
    }
}



