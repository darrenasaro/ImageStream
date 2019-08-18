//
//  Mapper.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

enum ImageDataError: Error {
    case noImageFromData
}
//data -> model
protocol Mapper {
    func map(data: Data) throws -> Any
}

class JSONMapper<T:Decodable>: Mapper {
    func map(data: Data) throws -> Any {
        return try JSONDecoder().decode(T.self, from: data)
    }
}

class ImageMapper: Mapper {
    //TODO: custom error
    func map(data: Data) throws -> Any {
        guard let image = UIImage(data: data) else {
            throw ImageDataError.noImageFromData
        }
        return image
    }
}
