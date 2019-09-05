//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/21/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

/// A Mapper that maps Data to a Decodable object
class JSONMapper<T:Decodable>: Mapper {
    func map(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
