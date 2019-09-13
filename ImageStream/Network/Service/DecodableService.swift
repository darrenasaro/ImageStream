//
//  DecodableService.swift
//  ImageStream
//
//  Created by Darren Asaro on 9/13/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

typealias DefaultDecodableService<T: Decodable> = DecodableService<JSONMapper<T>>

struct DecodableService<T: Mapper>: NetworkService where T.OutputType: Decodable {
    let downloader: NetworkDownloader
    let mapper: T
    
    init(downloader: NetworkDownloader = AFDownloader(), mapper: T) {
        self.downloader = downloader
        self.mapper = mapper
    }
}
