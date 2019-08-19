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
        collectionView.backgroundColor = ThemeManager.shared.currentTheme.colorTheme.light
        //collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "cell")
        
        return collectionView
    }()
    
    var viewModel: PhotoFetcher

    init(viewModel: PhotoFetcher) {
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
        viewModel.fetch()
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
    func totalPhotoCountReceived() {
        collectionView.reloadData()
    }
    
    //TODO: "invalid number of items in section" bug
    func photosReceived(newIndeces: NSRange) {
        var indexPathsToReload = [IndexPath]()
        for i in Range(newIndeces)! {
            indexPathsToReload.append(IndexPath(row: i, section: 0))
        }
        collectionView.reloadItems(at: indexPathsToReload)
    }
}

extension PhotoCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths[0].row > viewModel.photoModels.count {
            viewModel.fetch()
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
}

