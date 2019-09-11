//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

protocol NetworkService {
    associatedtype U: Mapper
    var mapper: U { get }
    var downloader: NetworkDownloader { get }
    func fetch(from url: String, completion: @escaping (Result<U.OutputType, Error>)->())
}

extension NetworkService {

    func fetch(from url: String, completion: @escaping (Result<U.OutputType, Error>)->()) {
        downloader.fetch(from: url) { (result) in
            switch result {
            case .success(let resultData):
                do {
                    let model: U.OutputType = try self.mapper.map(data: resultData)
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

typealias DecodableService<T: Decodable> = GeneralService<JSONMapper<T>>
typealias PhotoSearchService<T: PhotoSearchResult> = DecodableService<T>
typealias ImageService = GeneralService<ImageMapper>

struct GeneralService<T: Mapper>: NetworkService {

    let downloader: NetworkDownloader
    let mapper: T

    init(downloader: NetworkDownloader = AFDownloader(), mapper: T) {
        self.downloader = downloader
        self.mapper = mapper
    }
}
