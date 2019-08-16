//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

//downloads and maps to object
class NetworkService<T: Decodable> {
    
    private let downloader: NetworkDownloader
    private let mapper: Mapper
    
    init(downloader: NetworkDownloader = AFDownloader(),
         mapper: Mapper = JSONMapper()) {
        
        self.downloader = downloader
        self.mapper = mapper
    }
    
    func get(from url: String, completion: @escaping (T)->()) {
        downloader.get(from: url) { (result) in
            switch result {
            case .success(let resultData):
                do {
                    let model: T = try self.mapper.map(data: resultData)
                    completion(model)
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

class FlickrPhotoSearchService: NetworkService<FlickrPhotoSearchResult> { }

class FlickrPhotoInfoService: NetworkService<FlickrPhotoInfo> { }
