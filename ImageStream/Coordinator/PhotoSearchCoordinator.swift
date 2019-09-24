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

/// Searches for photo models by page from a URL.
class PhotoSearchCoordinator<T: PhotoSearchResult>: PhotoSearcher {
    typealias PhotoFetchCallback = (Result<[Photo],Error>) -> Void
    typealias PhotoSearchEndpoint = PaginatedEndpoint
    /// The url used to make retrieve the photo models.
    private var endpoint: PhotoSearchEndpoint
    private var service: DefaultDecodableService<T>
    
    var totalPhotoCount: Int?
    
    init(
        endpoint: PhotoSearchEndpoint,
        service: DefaultDecodableService<T> = DecodableService(mapper: JSONMapper<T>())
    ) {
        self.endpoint = endpoint
        self.service = service
    }

    // MARK: - API
    
    func fetchPhotos(for page: Int, completion: @escaping PhotoFetchCallback) {
        endpoint = endpoint.copy(with: page)
        fetchPhotos(with: completion)
    }

    func page(for index: Int) -> Int {
        return index/endpoint.perPage + 1
    }
}

// MARK: - Helper functions
extension PhotoSearchCoordinator {
    /// Helper method that attempts to retrieve photo models using the endpoint property
    private func fetchPhotos(with completion: @escaping PhotoFetchCallback) {
        service.fetch(from: endpoint.url) { (result) in
            switch result {
            case .success(let searchResult):
                if self.totalPhotoCount == nil { self.totalPhotoCount = searchResult.totalCount }
                completion(.success(searchResult.photos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
