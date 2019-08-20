//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/17/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

@objc protocol PhotoCellViewModelDelegate: class {
    @objc optional func received(image: UIImage)
}

class PhotoCellViewModel {
    
    weak var delegate: PhotoCellViewModelDelegate?
    
    var photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    //TODO: Add functionality to display error
    func fetchImage() {
        PhotoDataCoordinator().getData(from: photo.url) { [weak self] (result) in
            switch result {
            case .success(let image): self?.delegate?.received?(image: image)
            case .failure(let error): print(error)
            }
        }
    }
}
