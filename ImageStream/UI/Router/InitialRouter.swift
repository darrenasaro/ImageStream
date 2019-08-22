//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/20/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

/// Abstraction for a type that creates the initial UIViewController for the app.
protocol InitialRouter {
    func getInitialViewController() -> UIViewController
}

extension InitialRouter {
    func getInitialViewController() -> UIViewController {
        let urlBuilder = FlickrPhotoSearchURLBuilder(searchString: "minimal", perPage: 25)
        let photoSearcher = PhotoSearchCoordinator<FlickrPhotoSearchResult>(urlBuilder: urlBuilder)
        let viewModel = PhotoCollectionViewModel(searcher: photoSearcher)
        let photoCollectionViewController = PhotoCollectionViewController(viewModel: viewModel)
        return photoCollectionViewController
    }
}
