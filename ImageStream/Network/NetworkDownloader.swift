//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import Alamofire

enum Result<T, U: Error> {
    case success(_ result: T)
    case failure(_ error: U)
}

//gets Data from a url
protocol NetworkDownloader {
    func get(from: String, completion: @escaping (Result<Data, Error>)->())
}

class AFDownloader: NetworkDownloader {
    
    func get(from url: String, completion: @escaping (Result<Data, Error>)->()) {
        AF.request(url).responseData { (response) in
            if let value = response.value {
                completion(.success(value))
            } else if let error = response.error {
                completion(.failure(error))
            }
        }
    }
}
