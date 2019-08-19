//
//  FlickrPhotoCoordinator.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/17/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

//manages requests from a url
class PhotoCoordinator<T: PhotoSearchResult> {
    
    private var pageCount = 0
    private let perPage = 25
    
    private var urlBuilder: PaginatedURLBuilder
    
    init(urlBuilder: PaginatedURLBuilder) {
        self.urlBuilder = urlBuilder
    }
    //TODO: inject service?
    func get(completion: @escaping (Result<T,Error>)->()) {
        pageCount += 1
        urlBuilder.page = pageCount
        PhotoSearchService<T>().get(from: urlBuilder.url) { (result) in
            completion(result)
        }
    }
}
