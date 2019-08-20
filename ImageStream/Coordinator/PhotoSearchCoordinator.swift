//
//  FlickrPhotoCoordinator.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/17/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

//manages requests from a url
class PhotoSearchCoordinator<T: PhotoSearchResult> {
    
    private var urlBuilder: PaginatedURLBuilder
    private var lastFetchedPage = 0
    var totalPhotoCount: Int?
    
    init(urlBuilder: PaginatedURLBuilder) {
        self.urlBuilder = urlBuilder
    }
    //TODO: shouldn't be responsible for not refetching the same page?
    func getPhotosForPageContaining(index: Int, completion: @escaping (Result<[Photo],Error>)->()) {
        guard page(for: index) > lastFetchedPage else { return }
        urlBuilder.page = lastFetchedPage + 1
        getPhotos(with: completion)
        lastFetchedPage += 1
    }
    
    //TODO: inject service?
    private func getPhotos(with completion: @escaping (Result<[Photo],Error>)->()) {
        PhotoSearchService<T>().get(from: urlBuilder.url) { (result) in
            switch result {
            case .success(let searchResult):
                if self.totalPhotoCount == nil { self.totalPhotoCount = searchResult.totalCount }
                completion(.success(searchResult.photos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func page(for index: Int) -> Int {
        return index/urlBuilder.perPage + 1
    }
}
