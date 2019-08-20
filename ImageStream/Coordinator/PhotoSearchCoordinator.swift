//
//  FlickrPhotoCoordinator.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/17/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

protocol PhotoSearcher {
    var totalPhotoCount: Int? { get }
    func page(for index: Int) -> Int
    func getPhotos(for page: Int, completion: @escaping (Result<[Photo],Error>)->())
}

//uses PhotoSearchService and PaginatedURLBuilder to search for photo pages
class PhotoSearchCoordinator<T: PhotoSearchResult>: PhotoSearcher {
    
    private var urlBuilder: PaginatedURLBuilder
    var totalPhotoCount: Int?
    
    init(urlBuilder: PaginatedURLBuilder) {
        self.urlBuilder = urlBuilder
    }

    func getPhotos(for page: Int, completion: @escaping (Result<[Photo],Error>)->()) {
        urlBuilder.page = page
        getPhotos(with: completion)
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
    
    func page(for index: Int) -> Int {
        return index/urlBuilder.perPage + 1
    }
}
