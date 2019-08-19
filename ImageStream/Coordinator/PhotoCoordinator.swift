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
    
    private var lastFetchedPage = 0
    private let perPage = 25

    private var urlBuilder: PaginatedURLBuilder
    
    init(urlBuilder: PaginatedURLBuilder) {
        self.urlBuilder = urlBuilder
    }
    //TODO: inject service?
    func get(index: Int, completion: @escaping (Result<T,Error>)->()) {
        guard pageFor(index: index) > lastFetchedPage else { return }
        urlBuilder.page = lastFetchedPage + 1
        PhotoSearchService<T>().get(from: urlBuilder.url) { (result) in
            completion(result)
        }
        lastFetchedPage += 1
    }
    
    private func pageFor(index: Int) -> Int {
        return index/perPage + 1
    }
}
