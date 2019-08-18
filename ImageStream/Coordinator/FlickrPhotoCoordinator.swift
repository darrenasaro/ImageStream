//
//  FlickrPhotoCoordinator.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/17/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

class FlickrPhotoCoordinator {
    
    private var pageCount = 0
    private let perPage = 25
    
    func get(completion: @escaping (Result<FlickrPhotoSearchResult,Error>)->()) {
        pageCount += 1
        let searchRequest = FlickrPhotoSearchRequestBuilder(searchString: "surf", page: pageCount, perPage: perPage)

        FlickrPhotoSearchService().get(from: searchRequest.url) { (result) in
            completion(result)
        }
    }
}
