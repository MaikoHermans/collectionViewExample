//
//  CollectionViewCell.swift
//  Ridin'
//
//  Created by Fhict on 28/01/16.
//  Copyright © 2016 PowerCircleDesigns. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img_artwork: UIImageView!
    @IBOutlet weak var lbl_Name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
}
