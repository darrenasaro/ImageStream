//
//  AFDownloader.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/21/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import Alamofire

/// Gets Data from a URL using Alamofire.
class AFDownloader: NetworkDownloader {
    func fetch(from url: String, completion: @escaping (Result<Data, Error>)->()) {
        AF.request(url).responseData { (response) in
            if let value = response.value {
                completion(.success(value))
            } else if let error = response.error {
                completion(.failure(error))
            }
        }
    }
}
