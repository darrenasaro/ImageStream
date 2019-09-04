//
//  ViewController.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import UIKit

/// Displays a collection of photos
class PhotoCollectionViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = SquareCollectionViewLayout(itemsPerRow: 2)

        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = ThemeManager.color.light
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "cell")
        
        return collectionView
    }()
    
    var selectionCallback: ((Photo) -> Void)?
    var viewModel: PhotoCollectionViewModel

    init(viewModel: PhotoCollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.fetchPhoto(at: 0)
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension PhotoCollectionViewController: PhotoCollectionViewModelDelegate {
    /// Reload the whole collectionView if it's inconsistent with viewModel, otherwise reload visible indexPaths of the newly acquired photos
    func photosReceived(for indeces: NSRange) {
        if viewModel.totalPhotoCount > collectionView.numberOfItems(inSection: 0) {
            return collectionView.reloadData()
        }
        
        let indexPathsToReload = Array(Range(indeces)!).map({ IndexPath(row: $0, section: 0) })
        let visibleIndexPathsToReload = Set(collectionView.indexPathsForVisibleItems).intersection(Set(indexPathsToReload))
        collectionView.reloadItems(at: Array(visibleIndexPathsToReload))
    }
}

extension PhotoCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalPhotoCount
    }
    /// Display a PhotoCell with a viewModel if the corresponding Photo exists.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell
        guard viewModel.photoModels.indices.contains(indexPath.row) else { return photoCell }
        photoCell.viewModel = PhotoCellViewModel(photo: viewModel.photoModels[indexPath.row])
        return photoCell
    }
    /// Show detailed view of photo for selected index.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard viewModel.photoModels.indices.contains(indexPath.row) else { return }
        //showPhotoDetail(viewModel.photoModels[indexPath.row])
        selectionCallback?(viewModel.photoModels[indexPath.row])
    }
    /// Request more photos from viewModel for the upcoming indeces if necessary.
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let nextIndex = indexPaths[0].row
        if nextIndex > viewModel.photoModels.count {
            viewModel.fetchPhoto(at: nextIndex)
        }
    }
}

