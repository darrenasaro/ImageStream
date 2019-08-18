//
//  PhotoCollectionViewModel.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/17/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

@objc protocol PhotoCollectionViewModelDelegate: class {
    @objc optional func flickrImagesReceived()
}

class PhotoCollectionViewModel {
    weak var delegate: PhotoCollectionViewModelDelegate?
    
    var photoModels = [Photo]()
    
    func fetch() {
        FlickrPhotoCoordinator().get { [weak self] (result) in
            switch result {
            case .success(let photos):
                self?.photoModels = photos
                self?.delegate?.flickrImagesReceived?()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
