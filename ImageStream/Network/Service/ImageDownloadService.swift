//
//  ImageDownloadService.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/21/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

/// Downloads Data from a URL and maps it to a UIImage.
class ImageService: NetworkService<UIImage> {
    init() {
        super.init(mapper: ImageMapper())
    }
}
