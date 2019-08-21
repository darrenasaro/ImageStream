//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

enum Result<T, U: Error> {
    case success(_ result: T)
    case failure(_ error: U)
}

/// Abstraction for a type that gets Data from a URL.
protocol NetworkDownloader {
    func get(from url: String, completion: @escaping (Result<Data, Error>)->())
}
