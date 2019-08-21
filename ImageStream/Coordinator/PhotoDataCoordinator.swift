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
    //TODO: cache image data
    func getData(from url: String, completion: @escaping (Result<UIImage, Error>)->()) {
        ImageService().get(from: url) { (result) in
            completion(result)
        }
    }
}
