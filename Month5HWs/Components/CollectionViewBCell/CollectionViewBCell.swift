//
//  CollectionViewBCell.swift
//  Month5HWs
//
//  Created by Jarae on 17/5/23.
//

import UIKit

class CollectionViewBCell: UICollectionViewCell {
    static let reuseId = String(describing: CollectionViewBCell.self)
    static let nibName = String(describing: CollectionViewBCell.self)
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    
    func display(image: UIImage?, text: String) {
        imageView.image = image
        textLabel.text = text
    }

}
