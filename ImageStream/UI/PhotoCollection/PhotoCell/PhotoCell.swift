//
//  PhotoCollectionViewCell.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/17/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.alpha = 0
        return view
    }()
    
    var viewModel: PhotoCellViewModel? {
        didSet {
            setupViewModel()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    private func setupViewModel() {
        guard let viewModel = viewModel else { return }
        viewModel.delegate = self
        viewModel.fetchImage()
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoCell {
    override func prepareForReuse() {
        viewModel = nil
        imageView.image = nil
        imageView.alpha = 0
    }
}

extension PhotoCell: PhotoCellViewModelDelegate {
    func received(image: UIImage) {
        imageView.image = image
        UIView.animate(withDuration: 0.3) {
            self.imageView.alpha = 1
        }
    }
}
