//
//  PhotoCollectionViewModel.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/17/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

@objc protocol PhotoCollectionViewModelDelegate: class {
    @objc optional func totalPhotoCountReceived()
    @objc optional func photosReceived(newIndeces: NSRange)
}

protocol PhotoFetcher {
    var totalPhotoCount: Int? { get }
    var photoModels: [Photo] { get }
    var delegate: PhotoCollectionViewModelDelegate? { get set }
    func fetch(index: Int)
}

class PhotoCollectionViewModel<T: PhotoSearchResult>: PhotoFetcher {
    weak var delegate: PhotoCollectionViewModelDelegate?
    private var coordinator: PhotoSearchCoordinator<T>
    
    var totalPhotoCount: Int? {
        didSet {
            self.delegate?.totalPhotoCountReceived?()
        }
    }

    var photoModels = [Photo]()
    
    init(coordinator: PhotoSearchCoordinator<T>) {
        self.coordinator = coordinator
    }

    func fetch(index: Int) {
        coordinator.get(index: index) { [unowned self] (result) in
            switch result {
            case .success(let searchResult):
                let startIndex = self.photoModels.count
                if self.totalPhotoCount == nil { self.totalPhotoCount = searchResult.totalCount }
                self.photoModels.append(contentsOf: searchResult.photos)
                self.delegate?.photosReceived?(newIndeces: NSRange(location: startIndex, length: searchResult.photos.count))
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
