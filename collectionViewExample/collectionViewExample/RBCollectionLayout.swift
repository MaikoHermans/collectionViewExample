//
//  RBCollectionLayout.swift
//  collectionViewExample
//
//  Created by Fhict on 22/02/16.
//  Copyright © 2016 PowerCircleDesigns. All rights reserved.
//

import Foundation

class RBCollectionLayout: RBCollectionViewInfoFolderLayout
{
    var view: UIView!
    init(view: UIView){
        super.init()
        self.view = view
        setupLayout()
    }
    
    override init(){
        super.init()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout(){
        let numberofItems: CGFloat = 3
        
        let itemWidth = (CGRectGetWidth(view.frame)) / numberofItems
        cellSize = CGSizeMake(itemWidth, itemWidth)
        
        interItemSpacingX = 0
        interItemSpacingY = 0
    }
}