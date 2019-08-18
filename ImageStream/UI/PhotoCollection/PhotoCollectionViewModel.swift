//
//  PhotoCollectionViewModel.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/17/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

@objc protocol PhotoCollectionViewModelDelegate: class {
    @objc optional func flickrImagesReceived(newIndeces: NSRange)
}

class PhotoCollectionViewModel {
    weak var delegate: PhotoCollectionViewModelDelegate?
    
    //TODO: Inject Coordinator?
    var coordinator = FlickrPhotoCoordinator()
    var totalPhotoCount = 0
    var photoModels = [Photo]()
    private var fetching = false
    
    func fetch() {
        guard !fetching else { return }
        fetching = true

        coordinator.get { [unowned self] (result) in
            switch result {
            case .success(let searchResult):
                let startIndex = self.photoModels.count
                self.totalPhotoCount = searchResult.totalCount
                self.photoModels.append(contentsOf: searchResult.flickrPhotos)
                self.delegate?.flickrImagesReceived?(newIndeces: NSRange(location: startIndex, length: searchResult.flickrPhotos.count))
                
            case .failure(let error):
                print(error)
            }
            
            self.fetching = false
        }
    }
}
