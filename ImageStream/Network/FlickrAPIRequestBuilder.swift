//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

fileprivate let flickrAPIKey = "8fc4e611f9c6ebc9d1f8c48ff92ece14"

//TODO: Add more methods
enum FlickrAPIMethod: String {
    case photosSearch = "flickr.photos.search"
    case getInfo = "flickr.photos.getInfo"
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
    
    init(apiKey: String = flickrAPIKey, method: FlickrAPIMethod, queryArguments: [String : String]) {
        self.apiKey = apiKey
        self.method = method
        self.queryArguments = queryArguments
    }
}

class FlickrPhotoSearchRequestBuilder: FlickrAPIRequestBuilder {
    init(searchString: String) {
        let photoSearchMethod = FlickrAPIMethod.photosSearch
        let photoSearchQueryArgs = ["text" : searchString,
                                   "sort" : "relevance",
                                   "per_page" : "100",
                                   "extras" : "description,date_upload,owner_name",
                                   "format" : "json",
                                   "nojsoncallback" : "1"]
        
        super.init(method: photoSearchMethod,
                   queryArguments: photoSearchQueryArgs)
    }
}

class FlickrPhotoInfoRequestBuilder: FlickrAPIRequestBuilder {
    init(photoID: String) {
        let photoInfoMethod = FlickrAPIMethod.getInfo
        let photoInfoQueryArgs = ["photo_id" : photoID,
                                  "format" : "json",
                                  "nojsoncallback" : "1"]
        
        super.init(method: photoInfoMethod,
                   queryArguments: photoInfoQueryArgs)
    }
}



