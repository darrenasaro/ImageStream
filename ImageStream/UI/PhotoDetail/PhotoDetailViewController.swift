//
//  PhotoDetailViewController.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/19/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

class PhotoDetailViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.alpha = 0
        return view
    }()
    
    var viewModel: PhotoDetailViewModel

    init(viewModel: PhotoDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        setupViewModel()
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.fetchImage()
    }
}

extension PhotoDetailViewController: PhotoDetailViewModelDelegate {
    func received(image: UIImage) {
        imageView.image = image
        UIView.animate(withDuration: 0.3) {
            self.imageView.alpha = 1
        }
    }
}
