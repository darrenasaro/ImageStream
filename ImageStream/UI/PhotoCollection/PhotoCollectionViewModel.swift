//
//  PhotoCollectionViewModel.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/17/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

@objc protocol PhotoCollectionViewModelDelegate: class {
    @objc optional func photosReceived(newIndeces: NSRange)
}

//gets pages of photos as they are needed
class PhotoCollectionViewModel {
    
    weak var delegate: PhotoCollectionViewModelDelegate?
    private var searcher: PhotoSearcher
    
    var totalPhotoCount: Int {
        return searcher.totalPhotoCount ?? 0
    }

    var photoModels = [Photo]()
    private var lastFetchedPage: Int = 0
    
    init(searcher: PhotoSearcher) {
        self.searcher = searcher
    }

    
    func getPhoto(at index: Int) {
        let pageToGet = searcher.page(for: index)
        guard pageToGet > lastFetchedPage else { return }
        searchForPhotos(on: pageToGet)
        lastFetchedPage += 1
    }
    
    private func searchForPhotos(on page: Int) {
        searcher.getPhotos(for: page) { [unowned self] (result) in
            switch result {
            case .success(let photos):
                let startIndex = self.photoModels.count
                self.photoModels.append(contentsOf: photos)
                self.delegate?.photosReceived?(newIndeces: NSRange(location: startIndex, length: photos.count))
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
