//
//  ImageMapper.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/21/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

/// A Mapper that maps Data to a UIImage
class ImageMapper: Mapper {
    func map(data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw ImageDataError.noImageFromData
        }
        return image
    }
}

extension ImageMapper {
    /// An error type for failures converting Data to UIImage
    enum ImageDataError: Error {
        case noImageFromData
    }
}
