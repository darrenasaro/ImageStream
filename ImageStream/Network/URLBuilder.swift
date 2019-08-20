//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

fileprivate let flickrAPIKey = "8fc4e611f9c6ebc9d1f8c48ff92ece14"

protocol URLBuilder {
    var url: String { get }
}

protocol PaginatedURLBuilder: URLBuilder {
    var page: Int { get set }
    var perPage: Int { get }
}
//TODO: Add more methods
enum FlickrAPIMethod: String {
    case photosSearch = "flickr.photos.search"
    case getInfo = "flickr.photos.getInfo"
}

class FlickrURLBuilder: URLBuilder {
    private let baseUrl = "https://www.flickr.com/services/rest/"
    
    private var apiKey: String
    private var method: FlickrAPIMethod
    var queryArguments: [String : String]
    
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

class FlickrPhotoSearchURLBuilder: FlickrURLBuilder, PaginatedURLBuilder {
    var page: Int = 0
    let perPage: Int
    
    override var url: String {
        queryArguments["page"] = "\(page)"
        queryArguments["per_page"] = "\(perPage)"
        return super.url
    }
    
    init(searchString: String, perPage: Int) {
        self.perPage = perPage
        let photoSearchMethod = FlickrAPIMethod.photosSearch
        let photoSearchQueryArgs = ["text" : searchString,
                                    "sort" : "interestingness-desc",
                                    "extras" : "description,date_upload,owner_name",
                                    "format" : "json",
                                    "nojsoncallback" : "1"]
        
        super.init(method: photoSearchMethod,
                   queryArguments: photoSearchQueryArgs)
    }
}



