//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

//url -> model
class NetworkService<T> {
    
    private let downloader: NetworkDownloader
    private let mapper: Mapper
    
    init(downloader: NetworkDownloader = AFDownloader(),
         mapper: Mapper) {
        
        self.downloader = downloader
        self.mapper = mapper
    }
    
    func get(from url: String, completion: @escaping (Result<T,Error>)->()) {
        downloader.get(from: url) { (result) in
            switch result {
            case .success(let resultData):
                do {
                    //TODO: conditional binding
                    let model: T = try self.mapper.map(data: resultData) as! T
                    completion(.success(model))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

//url -> PhotoSearchResult model
class PhotoSearchService<T: PhotoSearchResult>: NetworkService<T> {
    init() {
        super.init(mapper: JSONMapper<T>())
    }
}

class ImageService: NetworkService<UIImage> {
    init() {
        super.init(mapper: ImageMapper())
    }
}
