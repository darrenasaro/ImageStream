//
//  PhotoDetailRoute.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/21/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

/// Abstraction for a type that can route to a view controller that displays a photo.
protocol PhotoDetailRouter {
    func showPhotoDetail(_ photo: Photo)
}

extension PhotoDetailRouter where Self: UIViewController {
    func showPhotoDetail(_ photo: Photo) {
        let photoDetailViewModel = PhotoDetailViewModel(photo: photo)
        let photoDetailViewController = PhotoDetailViewController(viewModel: photoDetailViewModel)
        let swipeViewController = SwipeViewController(viewController: photoDetailViewController)
        swipeViewController.modalPresentationStyle = .overCurrentContext
        self.present(swipeViewController, animated: false)
    }
}
