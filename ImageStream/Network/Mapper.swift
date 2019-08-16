//
//  Mapper.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

//converts Data into Decodable object
protocol Mapper {
    func map<T:Decodable>(data: Data) throws -> T
}

class JSONMapper: Mapper {
    func map<T>(data: Data) throws -> T where T : Decodable {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
