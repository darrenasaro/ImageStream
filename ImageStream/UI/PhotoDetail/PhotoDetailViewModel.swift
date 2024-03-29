//
//  PhotoDetailViewModel.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/19/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

@objc protocol PhotoDetailViewModelDelegate: class {
    @objc optional func received(image: UIImage)
}

/// Retrieves UIImage for a photo and notifies a delegate.
class PhotoDetailViewModel {
    
    weak var delegate: PhotoDetailViewModelDelegate?
    
    var photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    //TODO: Add functionality to display error
    func fetchImage() {
        PhotoDataCoordinator().fetchData(from: photo.url) { [weak self] (result) in
            switch result {
            case .success(let image): self?.delegate?.received?(image: image)
            case .failure(let error): print(error)
            }
        }
    }
}
