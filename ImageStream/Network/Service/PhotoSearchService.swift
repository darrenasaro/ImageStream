//
//  PhotoSearchService.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/21/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

/// Downloads Data from a URL and maps it to a PhotoSearchResult model.
class PhotoSearchService<T: PhotoSearchResult>: NetworkService<T> {
    init() {
        super.init(mapper: JSONMapper<T>())
    }
}
