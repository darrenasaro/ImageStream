//
//  SquareCollectionView.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/21/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

/// Create a layout for a UICollectionView which has square, equally spaced cells
class SquareCollectionViewLayout: UICollectionViewFlowLayout {
    
    private let itemsPerRow: Int
    private let itemSpacing: CGFloat = ThemeManager.dimension.margins
    
    init(itemsPerRow: Int) {
        self.itemsPerRow = itemsPerRow
        super.init()
        sectionInset = UIEdgeInsets(top: itemSpacing, left: itemSpacing, bottom: itemSpacing, right: itemSpacing)
        minimumLineSpacing = itemSpacing
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let itemDimension = (collectionView.frame.width - CGFloat(itemsPerRow + 1) * itemSpacing) / CGFloat(itemsPerRow)
        itemSize = CGSize(width: itemDimension, height: itemDimension)
    }
}
