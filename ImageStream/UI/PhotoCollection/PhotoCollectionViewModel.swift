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
    
    //TODO: requests on a serial queue
    /// Gets the page of photos for the index if it hasn't already been retrieved
    func fetchPhotos(for indices: [Int]) {
        for page in pagesToFetchFrom(indices) {
            searchForPhotos(on: page)
            lastFetchedPage = page
        }
    }
    
    private func pagesToFetchFrom(_ indices: [Int]) -> [Int] {
        guard indices.count > 0 else { return [] }
        let lastPage = searcher.page(for: indices.last!)
        guard lastPage > lastFetchedPage else { return [] }
        
        var pages = [Int]()
        for index in lastFetchedPage...lastPage {
            pages.append(index)
        }
        
        return pages
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
