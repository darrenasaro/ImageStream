//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkResult<T, U: Error> {
    case success(result: T)
    case failure(error: U)
}

//TODO: logically bind network layer to JSON
//gets Data from a url
protocol NetworkDownloader {
    func get(from: String, completion: @escaping (NetworkResult<Data, Error>)->())
}

class AFDownloader: NetworkDownloader {
    
    func get(from url: String, completion: @escaping (NetworkResult<Data, Error>)->()) {
        AF.request(url).responseData { (response) in
            if let value = response.value {
                completion(NetworkResult.success(result: value))
            } else if let error = response.error {
                completion(NetworkResult.failure(error: error))
            }
        }
    }
}