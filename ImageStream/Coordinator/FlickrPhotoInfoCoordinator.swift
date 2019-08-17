//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/16/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import Promises

//create simple API for getting models. Acts as middleman between UI and Network layers
class FlickrPhotoInfoCoordinator {
    
    func get(completion: @escaping (Result<[FlickrPhotoInfo],Error>)->()) {
        let searchRequest = FlickrPhotoSearchRequestBuilder(searchString: "surf")
        
        searchForPhotos(with: searchRequest.url)
            .then(getPhotoInfoFromSearchResults)
            .then { (flickrPhotoInfoArray) in completion(.success(flickrPhotoInfoArray)) }
            .catch { (error) in completion(.failure(error)) }
    }
    
    private func searchForPhotos(with url: String) -> Promise<FlickrPhotoSearchResult> {
        return Promise { (fulfill, reject) in
            FlickrPhotoSearchService().get(from: url) { (results) in
                switch results {
                case .success(let searchResults): fulfill(searchResults)
                case .failure(let error)        : reject(error)
                }
            }
        }
    }
    
    private func getPhotoInfoFromSearchResults(_ searchResults: FlickrPhotoSearchResult) -> Promise<[FlickrPhotoInfo]> {
        return all(searchResults.ids.map { (id) -> Promise<FlickrPhotoInfo> in
            return getPhotoInfo(id: id)
        })
    }
    
    private func getPhotoInfo(id: String) -> Promise<FlickrPhotoInfo> {
        return Promise { (fulfill, reject) in
            let infoRequest = FlickrPhotoInfoRequestBuilder(photoID: id)
            FlickrPhotoInfoService().get(from: infoRequest.url) { (results) in
                switch results {
                case .success(let photoInfo): fulfill(photoInfo)
                case .failure(let error)    : reject(error)
                }
            }
        }
    }
}
