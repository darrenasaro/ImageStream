//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/20/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

/// Abstraction for a type that can manage the routing between UIViewControllers.
protocol Router {
    var initialViewController: UIViewController? { get }
    func createInitialViewController()
}

/// Manages the routing between all UIViewControllers in the app
class MainRouter: Router {

    var initialViewController: UIViewController?
    
    func createInitialViewController() {
        let urlBuilder = FlickrPhotoSearchURLBuilder(searchString: "minimal", perPage: 25)
        let photoSearcher = PhotoSearchCoordinator<FlickrPhotoSearchResult>(urlBuilder: urlBuilder)
        let viewModel = PhotoCollectionViewModel(searcher: photoSearcher)
        let photoCollectionViewController = PhotoCollectionViewController(viewModel: viewModel)
        photoCollectionViewController.router = self
        initialViewController = photoCollectionViewController
    }

    func showPhotoDetail(photo: Photo) {
        let photoDetailViewModel = PhotoDetailViewModel(photo: photo)
        let photoDetailViewController = PhotoDetailViewController(viewModel: photoDetailViewModel)
        let swipeViewController = SwipeViewController(viewController: photoDetailViewController)
        swipeViewController.modalPresentationStyle = .overCurrentContext
        initialViewController?.present(swipeViewController, animated: false)
    }
}
