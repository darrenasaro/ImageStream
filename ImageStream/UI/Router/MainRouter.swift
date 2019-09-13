//
//  MainRouter.swift
//  ImageStream
//
//  Created by Darren Asaro on 9/4/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

class MainRouter: Router {
    private var photoCollectionViewController: PhotoCollectionViewController?
    
    func start() -> UIViewController {
        let urlBuilder = FlickrPhotoSearchURLBuilder(searchString: "minimal")
        let photoSearcher = PhotoSearchCoordinator<FlickrPhotoSearchResult>(urlBuilder: urlBuilder)
        let viewModel = PhotoCollectionViewModel(searcher: photoSearcher)
        photoCollectionViewController = PhotoCollectionViewController(viewModel: viewModel)
        photoCollectionViewController!.selectionCallback = { [weak self] photo in self?.route(to: photo) }
        return photoCollectionViewController!
    }
    
    func route(to photo: Photo) {
        let photoDetailViewModel = PhotoDetailViewModel(photo: photo)
        let photoDetailViewController = PhotoDetailViewController(viewModel: photoDetailViewModel)
        let swipeViewController = SwipeViewController(viewController: photoDetailViewController)
        photoCollectionViewController?.present(swipeViewController, animated: false)
    }
}
