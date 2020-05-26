//
//  FolderCollectionViewCell.swift
//  Original Application
//
//  Created by Kusunose Hosho on 2020/05/24.
//  Copyright © 2020 Kusunose Hosho. All rights reserved.
//

import UIKit

class FolderCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    static let identifier = "FolderCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with image: UIImage) {
        imageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "FolderCollectionViewCell", bundle: nil)
    }

}
