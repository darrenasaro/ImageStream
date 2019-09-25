//
//  PhotoCollectionViewModel.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/17/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

@objc protocol PhotoCollectionViewModelDelegate: class {
    @objc optional func photosReceived(for indeces: NSRange)
}

/// Stores all the Photo models and gets more as needed.
class PhotoCollectionViewModel {
    weak var delegate: PhotoCollectionViewModelDelegate?
    private var searcher: PhotoSearcher
    
    var totalPhotoCount: Int {
        return searcher.totalPhotoCount ?? 0
    }

    private(set) var photoModels = [Photo]()
    private var lastFetchedPage: Int = 0
    
    init(searcher: PhotoSearcher) {
        self.searcher = searcher
    }
    
    // MARK: - API
    
    // TODO: requests on a serial queue
    /// Gets the page of photos for the index if it hasn't already been retrieved
    func fetchPhotos(in range: ClosedRange<Int>) {
        for page in pagesToFetchFrom(range) {
            searchForPhotos(on: page)
            lastFetchedPage = page
        }
    }
}

// MARK: - Helper functions
extension PhotoCollectionViewModel {
    private func pagesToFetchFrom(_ range: ClosedRange<Int>) -> Range<Int> {
        let firstPageToFetch = max(lastFetchedPage + 1, range.lowerBound)
        let lastPageToFetch = max(firstPageToFetch, range.upperBound + 1)
        return firstPageToFetch..<lastPageToFetch
    }
    
    private func searchForPhotos(on page: Int) {
        searcher.fetchPhotos(for: page) { [unowned self] (result) in
            switch result {
            case .success(let photos):
                let startIndex = self.photoModels.count
                self.photoModels.append(contentsOf: photos)
                self.delegate?.photosReceived?(for: NSRange(location: startIndex, length: photos.count))
                
            case .failure(let error):
                print(error)
            }
        }
    }
}


