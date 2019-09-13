//
//  PhotoDownloadCoordinator.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/19/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

/// Attempts to retrieve a UIImage from a URL.
class PhotoDataCoordinator {
    
    private let service: DefaultImageService
    
    init(service: DefaultImageService = ImageService(mapper: ImageMapper())) {
        self.service = service
    }
    //TODO: cache image data
    func fetchData(from url: String, completion: @escaping (Result<UIImage, Error>)->()) {
        service.fetch(from: url) { (result) in
            completion(result)
        }
    }
}
