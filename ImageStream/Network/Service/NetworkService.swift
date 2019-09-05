//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    associatedtype T
    func fetch(from url: String, completion: @escaping (Result<T,Error>)->())
}
//TODO: Make mapper associated type then use typealiases to simplify everything
/// Downloads Data from a URL and maps it to a type.

typealias DecodableService<T: Decodable> = NetworkService<JSONMapper<T>>
typealias PhotoSearchService<T: PhotoSearchResult> = DecodableService<T>
typealias ImageDownloadService = NetworkService<ImageMapper>

class NetworkService<T: Mapper>: NetworkServiceProtocol {
    
    private let downloader: NetworkDownloader
    private let mapper: T
    
    init(downloader: NetworkDownloader = AFDownloader(),
         mapper: T) {
        
        self.downloader = downloader
        self.mapper = mapper
    }
    
    func fetch(from url: String, completion: @escaping (Result<T.T,Error>)->()) {
        downloader.fetch(from: url) { (result) in
            switch result {
            case .success(let resultData):
                do {
                    let model: T.T = try self.mapper.map(data: resultData)
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
