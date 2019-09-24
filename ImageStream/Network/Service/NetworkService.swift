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
    func fetch(from url: String, completion: @escaping (Result<U.OutputType, Error>) -> Void)
}

extension NetworkService {
    func fetch(from url: String, completion: @escaping (Result<U.OutputType, Error>) -> Void) {
        downloader.fetch(from: url) { (result) in
            switch result {
            case .success(let resultData):
                completion(Result(catching: { try self.mapper.map(data: resultData) }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
