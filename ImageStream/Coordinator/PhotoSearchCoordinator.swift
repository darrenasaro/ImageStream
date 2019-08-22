//
//  FlickrPhotoCoordinator.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/17/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

/// Abstraction for a type that searches for pages of photo models within collection.
protocol PhotoSearcher {
    /// The total amount of photo models accessible.
    var totalPhotoCount: Int? { get }
    /// The page which contains a specified index.
    func page(for index: Int) -> Int
    /// Attempts to retrieve all the photo models on a specified page.
    func fetchPhotos(for page: Int, completion: @escaping (Result<[Photo],Error>)->())
}

/// Searches for photo models by page from a URL
class PhotoSearchCoordinator<T: PhotoSearchResult>: PhotoSearcher {
    /// The url used to make retrieve the photo models
    private var urlBuilder: PaginatedURLBuilder
    var totalPhotoCount: Int?
    
    init(urlBuilder: PaginatedURLBuilder) {
        self.urlBuilder = urlBuilder
    }

    func fetchPhotos(for page: Int, completion: @escaping (Result<[Photo],Error>)->()) {
        urlBuilder.page = page
        fetchPhotos(with: completion)
    }
    
    //TODO: inject service?
    /// Helper method that attempts to retrieve photo models using the urlBuilder property
    private func fetchPhotos(with completion: @escaping (Result<[Photo],Error>)->()) {
        PhotoSearchService<T>().fetch(from: urlBuilder.url) { (result) in
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
