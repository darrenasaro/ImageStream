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
        let itemsPerRow: CGFloat = 3
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
    
    func setupViewModel() {
        viewModel.delegate = self
        viewModel.fetch()
    }
    
    func setupCollectionView() {
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
    func flickrImagesReceived() {
        collectionView.reloadData()
    }
}

extension PhotoCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photoModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell
        photoCell.viewModel = PhotoCellViewModel(photo: viewModel.photoModels[indexPath.row])
        return photoCell
    }
}

