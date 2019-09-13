//
//  ImageService.swift
//  ImageStream
//
//  Created by Darren Asaro on 9/13/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

typealias DefaultImageService = ImageService<ImageMapper>

struct ImageService<T: Mapper>: NetworkService where T.OutputType == UIImage {
    let downloader: NetworkDownloader
    let mapper: T
    
    init(downloader: NetworkDownloader = AFDownloader(), mapper: T) {
        self.downloader = downloader
        self.mapper = mapper
    }
}
