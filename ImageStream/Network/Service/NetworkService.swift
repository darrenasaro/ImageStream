//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

/// Downloads Data from a URL and maps it to a type.
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
