//
//  FlickrSearchPhotoURLBuilder.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/21/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

/// Creates a URL specific to the Flickr API's photosSearch method.
class FlickrPhotoSearchURLBuilder: FlickrURLBuilder, PaginatedURLBuilder {
    var page: Int = 0
    var perPage: Int = 25
    
    /// Constructs url by first incorporating page requirements into the queryArguments
    override var url: String {
        queryArguments["page"] = "\(page)"
        queryArguments["per_page"] = "\(perPage)"
        return super.url
    }
    
    init(searchString: String) {
        let photoSearchMethod = Method.photosSearch
        let photoSearchQueryArgs = ["text": searchString,
                                    "sort": "interestingness-desc",
                                    "extras": "description,date_upload,owner_name",
                                    "format": "json",
                                    "nojsoncallback": "1"]
        
        super.init(method: photoSearchMethod,
                   queryArguments: photoSearchQueryArgs)
    }
}
