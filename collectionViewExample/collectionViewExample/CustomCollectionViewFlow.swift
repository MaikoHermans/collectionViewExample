//
//  CustomCollectionViewFlow.swift
//  Ridin'
//
//  Created by Fhict on 28/01/16.
//  Copyright © 2016 PowerCircleDesigns. All rights reserved.
//

import UIKit

class CustomCollectionViewFlow: UICollectionViewFlowLayout{
    override init(){
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    override var itemSize: CGSize {
        set {
            
        }
        get {
            let numberOfColumns: CGFloat = 3
            
            let itemWidth = (CGRectGetWidth(self.collectionView!.frame)) / numberOfColumns
            return CGSizeMake(itemWidth, itemWidth)
        }
    }
    
    func setupLayout() {
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .Vertical
    }

}
