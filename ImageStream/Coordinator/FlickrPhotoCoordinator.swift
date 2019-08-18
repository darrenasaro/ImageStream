//
//  FlickrPhotoCoordinator.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/17/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

class FlickrPhotoCoordinator {
    
    func get(completion: @escaping (Result<[FlickrPhoto],Error>)->()) {
        let searchRequest = FlickrPhotoSearchRequestBuilder(searchString: "surf")
        
        FlickrPhotoSearchService().get(from: searchRequest.url) { (result) in
            switch result {
            case .success(let searchResult): completion(.success(searchResult.flickrPhotos))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
