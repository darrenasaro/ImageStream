//
//  ViewController.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let itemsPerRow: CGFloat = 2
        let itemSpacing: CGFloat = ThemeManager.shared.currentTheme.dimensionTheme.margins
        let itemDimension = (view.frame.width-(itemsPerRow+1)*itemSpacing)/itemsPerRow
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: itemSpacing, left: itemSpacing, bottom: itemSpacing, right: itemSpacing)
        layout.itemSize = CGSize(width: itemDimension, height: itemDimension)
        
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        //collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "cell")
        
        return collectionView
    }()
    
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
        // Do any additional setup after loading the view.
        setupViewModel()
        setupCollectionView()
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.getPhoto(at: 0)
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension PhotoCollectionViewController: PhotoCollectionViewModelDelegate {

    func photosReceived(newIndeces: NSRange) {
        //if the new totalPhotoCunt exceeds current number of items in the collectionView, reload
        if viewModel.totalPhotoCount > collectionView.numberOfItems(inSection: 0) {
            return collectionView.reloadData()
        }
        
        let indexPathsToReload = Array(Range(newIndeces)!).map({ IndexPath(row: $0, section: 0) })
        let visibleIndexPathsToReload = Set(collectionView.indexPathsForVisibleItems).intersection(Set(indexPathsToReload))
        collectionView.reloadItems(at: Array(visibleIndexPathsToReload))
    }
}

extension PhotoCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let nextIndex = indexPaths[0].row
        if nextIndex > viewModel.photoModels.count {
            viewModel.getPhoto(at: nextIndex)
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalPhotoCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell
        guard indexPath.row < viewModel.photoModels.count else { return photoCell }
        photoCell.viewModel = PhotoCellViewModel(photo: viewModel.photoModels[indexPath.row])
        return photoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoDetailViewModel = PhotoDetailViewModel(photo: viewModel.photoModels[indexPath.row])
        let photoDetailViewController = PhotoDetailViewController(viewModel: photoDetailViewModel)
        let swipeViewController = SwipeViewController(viewController: photoDetailViewController)
        swipeViewController.modalPresentationStyle = .overCurrentContext
        present(swipeViewController, animated: false)
    }
}

