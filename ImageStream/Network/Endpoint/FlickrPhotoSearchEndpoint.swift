//
//  FlickrSearchPhotoURLBuilder.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/21/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

/// Creates a URL specific to the Flickr API's photosSearch method.
class FlickrPhotoSearchEndpoint: FlickrAPIEndpoint, PaginatedEndpoint {
    let page: Int
    let perPage: Int
    private let searchInput: String
    
    init(searchInput: String, page: Int = 0, perPage: Int = 25) {
        self.searchInput = searchInput
        self.page = page
        self.perPage = perPage
        super.init(
            method: .photosSearch,
            queryItems: [
                "text": searchInput,
                "sort": "interestingness-desc",
                "page": "\(page)",
                "per_page": "\(perPage)",
                "extras": "description,date_upload,owner_name",
                "format": "json",
                "nojsoncallback": "1"
            ]
        )
    }
    
    func copy(with newPage: Int) -> PaginatedEndpoint {
        return FlickrPhotoSearchEndpoint(searchInput: searchInput, page: newPage, perPage: perPage)
    }
}
