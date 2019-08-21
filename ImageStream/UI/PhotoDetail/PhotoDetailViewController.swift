//
//  PhotoDetailViewController.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/19/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

/// Detailed view for a Photo model
class PhotoDetailViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.alpha = 0
        return view
    }()
    
    private lazy var bottomBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ThemeManager.color.light
        view.hasShadow = true
        return view
    }()
    
    private lazy var usernameLabel: Label = {
        let label = Label(style: .titleSmall)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = viewModel.photo.username
        return label
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
        setupBottomBar()
        setupUsernameLabel()
        
        setupViewModel()
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    private func setupBottomBar() {
        view.addSubview(bottomBar)
        NSLayoutConstraint.activate([
            bottomBar.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            bottomBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupUsernameLabel() {
        bottomBar.addSubview(usernameLabel)
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: bottomBar.layoutMarginsGuide.topAnchor),
            usernameLabel.bottomAnchor.constraint(equalTo: bottomBar.layoutMarginsGuide.bottomAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
        ])
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.getImage()
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
